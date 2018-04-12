ActiveAdmin.register Custodian do
  menu parent: 'Lists', priority: 1, if: proc { current_account.account_type.name != 'Standard' }

  permit_params :employee_id, :custodian_account_id

  config.sort_order = 'id_asc'

  before_save do |custodian|
    custodian.created_by_id = current_account.employee_id if custodian.new_record?
    custodian.updated_by_id = current_account.employee_id if !custodian.new_record?
  end

  index do
    selectable_column
    column 'Name' do |custodian|
      link_to custodian.name, admin_custodian_path(custodian)
    end
    column :created_at
    column :updated_at
    column 'Created by' do |custodian|
      custodian.created_by_id? ? link_to(custodian.created_by.full_name, admin_employee_path(custodian.created_by)) : ''
    end
    column 'Updated by' do |custodian|
      custodian.created_by_id? ? link_to(custodian.updated_by.full_name, admin_employee_path(custodian.updated_by)) : ''
    end
    actions
  end

  filter :name_cont, label: 'Name'
  filter :created_at, as: :date_range
  filter :updated_at, as: :date_range
  filter :created_by_first_name_or_created_by_middle_initial_or_created_by_last_name_cont, label: 'Created by'
  filter :updated_by_first_name_or_created_by_middle_initial_or_created_by_last_name_cont, label: 'Updated by'

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