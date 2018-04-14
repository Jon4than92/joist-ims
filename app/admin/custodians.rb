ActiveAdmin.register Custodian do
  menu parent: 'Lists', priority: 1, if: proc { current_account.account_type.name != 'Standard' }

  permit_params :employee_id, :custodian_account_id

  config.sort_order = 'id_asc'

  controller do

    before_save do |custodian|
      custodian.created_by_id = current_account.employee_id if custodian.new_record?
      custodian.updated_by_id = current_account.employee_id if !custodian.new_record?
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
    selectable_column
    column 'Name' do |custodian|
      link_to custodian.employee.full_name, admin_custodian_path(custodian)
    end
    column 'Account' do |custodian|
      link_to custodian.custodian_account.name, admin_custodian_account_path(custodian.custodian_account)
    end
    column :created_at
    column :updated_at
    column 'Created by' do |custodian|
      custodian.created_by_id? ? link_to(custodian.created_by.full_name, admin_employee_path(custodian.created_by)) : ''
    end
    column 'Updated by' do |custodian|
      custodian.updated_by_id? ? link_to(custodian.updated_by.full_name, admin_employee_path(custodian.updated_by)) : ''
    end
    actions
  end

  filter :employee_first_name_or_employee_middle_initial_or_employee_last_name_cont, label: 'Name'
  filter :custodian_account_name_cont, label: 'Account'
  filter :created_at, as: :date_range
  filter :updated_at, as: :date_range
  filter :created_by_first_name_or_created_by_middle_initial_or_created_by_last_name_cont, label: 'Created by'
  filter :updated_by_first_name_or_created_by_middle_initial_or_created_by_last_name_cont, label: 'Updated by'

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :employee_id, label: 'Employee', as: :select, collection: Employee.all.map{|u| [u.full_name, u.id]}, required: true
      f.input :custodian_account_id, label: 'Custodian account', as: :select, collection: CustodianAccount.all.map{|u| [u.name, u.id]}, required: true
    end
    f.actions
  end

  show do
    attributes_table title: 'Custodian' do
      row :name
    end

    attributes_table title: 'Metadata' do
      row 'Created by' do |custodian|
        txt = []
        txt << (custodian.created_by_id? ? link_to(custodian.created_by.full_name, admin_employee_path(custodian.created_by)) : '<strong>Deleted User</strong>')
        txt << " on #{custodian.created_at.in_time_zone('Central Time (US & Canada)').strftime("%B %d, %Y (%I:%M%P)")}"
        txt.join.html_safe
      end
      row 'Last updated by' do |custodian|
        if custodian.updated_by_id?
          txt = []
          txt << link_to(custodian.updated_by.full_name, admin_employee_path(custodian.updated_by))
          txt << " on #{custodian.updated_at.in_time_zone('Central Time (US & Canada)').strftime("%B %d, %Y (%I:%M%P)")}"
          txt.join.html_safe
        else
          '<span class="empty">Empty</span>'.html_safe
        end
      end
    end
  end
end