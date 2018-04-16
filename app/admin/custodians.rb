ActiveAdmin.register Custodian do
  actions :index, :show

  menu parent: 'Lists', priority: 1, if: proc { current_account.account_type.name != 'Standard' }

  permit_params :employee_id, :custodian_account_id

  config.sort_order = 'id_asc'

  controller do
    before_save do |custodian|
      custodian.created_by_id = current_account.employee_id
    end

    before_action :check_account_type, action: :all
    def check_account_type
      if current_account.account_type.name == 'Standard'
        flash[:error] = 'You don\'t have access to that page.'
        redirect_to admin_employee_path(current_account)
      end
    end
  end

  index do
    column 'Name' do |custodian|
      link_to custodian.employee.full_name, admin_employee_path(custodian.employee)
    end
    column 'Account' do |custodian|
      link_to custodian.custodian_account.name, admin_custodian_account_path(custodian.custodian_account)
    end
    column :created_at
    column 'Created by' do |custodian|
      custodian.created_by_id? ? link_to(custodian.created_by.full_name, admin_employee_path(custodian.created_by)) : 'Deleted User'
    end
  end

  filter :employee_first_name_or_employee_middle_initial_or_employee_last_name_cont, label: 'Name'
  filter :custodian_account_name_cont, label: 'Account'
  filter :created_at, as: :date_range
  filter :created_by_first_name_or_created_by_middle_initial_or_created_by_last_name_cont, label: 'Created by'

  show do
    attributes_table title: 'Custodian' do
      row :employee_id, label: 'Employee' do |custodian|
        link_to custodian.employee.full_name, admin_employee_path(custodian.employee)
      end
      row :custodian_account_id, label: 'Custodian account' do |custodian|
        link_to custodian.custodian_account.name, admin_custodian_account_path(custodian.custodian_account)
      end
    end

    attributes_table title: 'Metadata' do
      row 'Created by' do |custodian|
        txt = []
        txt << (custodian.created_by_id? ? link_to(custodian.created_by.full_name, admin_employee_path(custodian.created_by)) : '<strong>Deleted User</strong>')
        txt << " on #{custodian.created_at.in_time_zone('Central Time (US & Canada)').strftime("%B %d, %Y (%I:%M%P)")}"
        txt.join.html_safe
      end
    end
  end
end