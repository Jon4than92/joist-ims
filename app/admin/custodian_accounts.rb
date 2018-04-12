ActiveAdmin.register CustodianAccount do
  menu parent: 'Lists', priority: 2, if: proc { current_account.account_type.name != 'Standard' }

  permit_params :name, custodian_attributes: [:id, :employee_id, :_destroy]

  config.sort_order = 'name_desc'

  before_save do |custodian_account|
    custodian_account.created_by_id = current_account.employee_id if custodian_account.new_record?
    custodian_account.updated_by_id = current_account.employee_id if !custodian_account.new_record?
  end

  index do
    selectable_column
    column 'Name' do |custodian_account|
      link_to custodian_account.name, admin_custodian_account_path(custodian_account)
    end
    column :created_at
    column :updated_at
    column 'Created by' do |custodian_account|
      custodian_account.created_by_id? ? link_to(custodian_account.created_by.full_name, admin_employee_path(custodian_account.created_by)) : ''
    end
    column 'Updated by' do |custodian_account|
      custodian_account.created_by_id? ? link_to(custodian_account.updated_by.full_name, admin_employee_path(custodian_account.updated_by)) : ''
    end
    actions
  end

  filter :name_cont, label: 'Name'
  filter :created_at, as: :date_range
  filter :updated_at, as: :date_range
  filter :created_by_first_name_or_created_by_middle_initial_or_created_by_last_name_cont, label: 'Created by'
  filter :updated_by_first_name_or_created_by_middle_initial_or_created_by_last_name_cont, label: 'Updated by'

  show do
    attributes_table title: 'Custodian Account' do
      row :name
    end

    attributes_table title: 'Metadata' do
      row 'Created by' do |custodian_account|
        txt = []
        txt << (custodian_account.created_by_id? ? link_to(custodian_account.created_by.full_name, admin_employee_path(custodian_account.created_by)) : '<strong>Deleted User</strong>')
        txt << " on #{custodian_account.created_at.in_time_zone('Central Time (US & Canada)').strftime("%B %d, %Y (%I:%M%P)")}"
        txt.join.html_safe
      end
      row 'Last updated by' do |custodian_account|
        if custodian_account.updated_by_id?
          txt = []
          txt << link_to(custodian_account.updated_by.full_name, admin_employee_path(custodian_account.updated_by))
          txt << " on #{custodian_account.updated_at.in_time_zone('Central Time (US & Canada)').strftime("%B %d, %Y (%I:%M%P)")}"
          txt.join.html_safe
        else
          '<span class="empty">Empty</span>'.html_safe
        end
      end
    end
  end
end