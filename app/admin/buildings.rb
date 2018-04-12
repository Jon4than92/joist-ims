ActiveAdmin.register Building do
  menu parent: 'Lists', priority: 6, if: proc { current_account.account_type.name != 'Standard' }

  permit_params :name

  config.sort_order = 'name_desc'

  controller do
    before_save do |building|
      building.created_by_id = current_account.employee_id if building.new_record?
      building.updated_by_id = current_account.employee_id if !building.new_record?
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
    column 'Name' do |building|
      link_to building.name, admin_building_path(building)
    end
    column :created_at
    column :updated_at
    column 'Created by' do |building|
      building.created_by_id? ? link_to(building.created_by.full_name, admin_employee_path(building.created_by)) : ''
    end
    column 'Updated by' do |building|
      building.updated_by_id? ? link_to(building.updated_by.full_name, admin_employee_path(building.updated_by)) : ''
    end
    actions
  end

  filter :name_cont, label: 'Name'
  filter :created_at, as: :date_range
  filter :updated_at, as: :date_range
  filter :created_by_first_name_or_created_by_middle_initial_or_created_by_last_name_cont, label: 'Created by'
  filter :updated_by_first_name_or_created_by_middle_initial_or_created_by_last_name_cont, label: 'Updated by'

  show do
    attributes_table title: 'Building' do
      row :name
    end

    attributes_table title: 'Metadata' do
      row 'Created by' do |building|
        txt = []
        txt << (building.created_by_id? ? link_to(building.created_by.full_name, admin_employee_path(building.created_by)) : '<strong>Deleted User</strong>')
        txt << " on #{building.created_at.in_time_zone('Central Time (US & Canada)').strftime("%B %d, %Y (%I:%M%P)")}"
        txt.join.html_safe
      end
      row 'Last updated by' do |building|
        if building.updated_by_id?
          txt = []
          txt << link_to(building.updated_by.full_name, admin_employee_path(building.updated_by))
          txt << " on #{building.updated_at.in_time_zone('Central Time (US & Canada)').strftime("%B %d, %Y (%I:%M%P)")}"
          txt.join.html_safe
        else
          '<span class="empty">Empty</span>'.html_safe
        end
      end
    end
  end
end
