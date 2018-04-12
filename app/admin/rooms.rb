ActiveAdmin.register Room do
  menu parent: 'Lists', priority: 5, if: proc { current_account.account_type.name != 'Standard' }

  permit_params :name, :building_id

  config.sort_order = 'name_desc'

  before_save do |room|
    room.created_by_id = current_account.employee_id if room.new_record?
    room.updated_by_id = current_account.employee_id if !room.new_record?
  end

  index do
    selectable_column
    column 'Room' do |room|
      link_to room.name, admin_room_path(room)
    end
    column 'Building' do |room|
      link_to room.building.name, admin_building_path(room.building)
    end
    column :created_at
    column :updated_at
    column 'Created by' do |room|
      room.created_by_id? ? link_to(room.created_by.full_name, admin_employee_path(room.created_by)) : ''
    end
    column 'Updated by' do |room|
      room.updated_by_id? ? link_to(room.updated_by.full_name, admin_employee_path(room.updated_by)) : ''
    end
    actions
  end

  filter :name_cont, label: 'Room'
  filter :building_name_cont, label: 'Building'
  filter :created_at, as: :date_range
  filter :updated_at, as: :date_range
  filter :created_by_first_name_or_created_by_middle_initial_or_created_by_last_name_cont, label: 'Created by'
  filter :updated_by_first_name_or_created_by_middle_initial_or_created_by_last_name_cont, label: 'Updated by'

  show do
    attributes_table title: 'Room' do
      row :name
    end

    attributes_table title: 'Metadata' do
      row 'Created by' do |room|
        txt = []
        txt << (room.created_by_id? ? link_to(room.created_by.full_name, admin_employee_path(room.created_by)) : '<strong>Deleted User</strong>')
        txt << " on #{room.created_at.in_time_zone('Central Time (US & Canada)').strftime("%B %d, %Y (%I:%M%P)")}"
        txt.join.html_safe
      end
      row 'Last updated by' do |room|
        if room.updated_by_id?
          txt = []
          txt << link_to(room.updated_by.full_name, admin_employee_path(room.updated_by))
          txt << " on #{room.updated_at.in_time_zone('Central Time (US & Canada)').strftime("%B %d, %Y (%I:%M%P)")}"
          txt.join.html_safe
        else
          '<span class="empty">Empty</span>'.html_safe
        end
      end
    end
  end
end