ActiveAdmin.register Hardware do
  permit_params :name, :manufacturer_id, :year, :model_num, :tag_num, :serial_num, :cost, :condition, :notes, :room_id, :assigned_to_id, :assigned_date, :custodian_id, :created_by_id, :updated_by_id

  menu if: proc { current_account.account_type.name != 'Standard' }

  config.sort_order = 'id_desc'

  controller do
    def scoped_collection
      end_of_association_chain.includes(room: :building, assigned_to: :account, updated_by: :account, created_by: :account)
    end

    before_save do |employee|
      employee.created_by_id = current_account.employee_id if employee.new_record?
      employee.updated_by_id = current_account.employee_id if !employee.new_record?
    end
  end

  index do
    selectable_column
    column :name do |hardware|
      link_to hardware.name, admin_hardware_path(hardware)
    end
    column 'Manufacturer', sortable: 'manufacturers.name' do |hardware|
      link_to hardware.manufacturer.name, admin_manufacturer_path(hardware.manufacturer)
    end
    column :model_num
    column :tag_num
    column :serial_num
    column 'Cost' do |hardware|
      number_to_currency(hardware.cost, unit: '$')
    end
    column 'Building', sortable: 'buildings.name' do |hardware|
      hardware.room.building.name
    end
    column 'Room', sortable: 'rooms.name' do |hardware|
      hardware.room.name
    end
    actions

    div class: 'panel' do
      h3 "Total Hardware Asset Value: #{ number_to_currency Hardware.search(params[:q]).result.sum(:cost)}"
    end
  end

  filter :name_cont, label: 'Name'
  filter :manufacturer_name_cont, label: 'Manufacturer'
  filter :year, label: 'Year manufactured', as: :numeric_range_filter
  filter :model_num_cont, label: 'Model number'
  filter :tag_num_cont, label: 'Tag number'
  filter :serial_num_cont, label: 'Serial number'
  filter :cost, as: :numeric_range_filter
  filter :condition_cont, label: 'Condition'
  filter :notes_cont, label: 'Notes'
  filter :room_name_cont, label: 'Room'
  filter :room_building_name_cont, label: 'Building'
  filter :assigned_to_first_name_or_assigned_to_middle_initial_or_assigned_to_last_name_cont, label: 'Assigned to'
  filter :custodian_employee_first_name_or_custodian_employee_middle_initial_or_custodian_employee_last_name_cont, label: 'Custodian'
  filter :custodian_custodian_account_name_cont, label: 'Custodian account'

  #filter :assigned_date, as: :date_range, label: 'Date assigned to employee'
  #filter :created_at, as: :date_range
  #filter :updated_at, as: :date_range
  #filter :created_by_first_name_or_created_by_middle_initial_or_created_by_last_name_cont, label: 'Created by'
  #filter :updated_by_first_name_or_created_by_middle_initial_or_created_by_last_name_cont, label: 'Updated by'

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name, required: true
      f.input :manufacturer_id, label: 'Manufacturer', as: :select, collection: Manufacturer.all.map{|u| [u.name, u.id]}, required: true, input_html: { class: "select2" }
      f.input :year, required: true
      f.input :model_num, required: true
      f.input :tag_num, required: true
      f.input :serial_num, required: true
      f.input :cost, label: 'Cost ($)', required: true, input_html: { min: 0 }
      f.input :condition, required: true
      f.input :room_id, required: true, as: :nested_select,
              level_1: { attribute: :building_id, collection: Building.all },
              level_2: { attribute: :room_id, collection: Room.all }
      f.input :assigned_to_id, label: 'Assigned to employee', as: :select, collection: Employee.all.map{|u| [u.full_name, u.id]}
      f.input :custodian_id, label: 'Assigned to custodian', as: :select, collection: Custodian.all.map{|u| ["#{u.employee.full_name}, #{u.custodian_account.name}", u.id]}
      f.input :notes, input_html: { rows: 8 }
    end
    f.actions
  end

  show do
    attributes_table title: 'Hardware' do
      row :name
      row 'Manufacturer' do |hardware|
        link_to hardware.manufacturer.name, admin_manufacturer_path(hardware.manufacturer)
      end
      row :year
      row :model_num
      row :tag_num
      row :serial_num
      row 'Cost' do |hardware|
        number_to_currency(hardware.cost, unit: '$')
      end
      row :condition
      row 'Building' do |hardware|
        link_to hardware.room.building.name, admin_building_path(hardware.room.building)
      end
      row 'Room' do |hardware|
        link_to hardware.room.name, admin_room_path(hardware.room)
      end
      row 'Assigned to employee' do |hardware|
        if hardware.assigned_to_id?
          txt = []
          txt << link_to(hardware.assigned_to.full_name, admin_employee_path(hardware.assigned_to))
          txt << " on #{hardware.assigned_date.in_time_zone('Central Time (US & Canada)').strftime("%B %d, %Y")}"
          txt.join.html_safe
        else
          '<span class="empty">Empty</span>'.html_safe
        end
      end
      row 'Assigned to custodian' do |hardware|
        if hardware.custodian_id?
          link_to hardware.custodian.employee.full_name, admin_custodian_path(hardware.custodian.employee)
        else
          '<span class="empty">Empty</span>'.html_safe
        end
      end
      row :notes
    end

    attributes_table title: 'Metadata' do
      row 'Created by' do |hardware|
        txt = []
        txt << (hardware.created_by_id? ? link_to(hardware.created_by.full_name, admin_employee_path(hardware.created_by)) : '<strong>Deleted User</strong>')
        txt << " on #{hardware.created_at.in_time_zone('Central Time (US & Canada)').strftime("%B %d, %Y (%I:%M%P)")}"
        txt.join.html_safe
      end
      row 'Last updated by' do |hardware|
        if hardware.updated_by_id?
          txt = []
          txt << link_to(hardware.updated_by.full_name, admin_employee_path(hardware.updated_by))
          txt << " on #{hardware.updated_at.in_time_zone('Central Time (US & Canada)').strftime("%B %d, %Y (%I:%M%P)")}"
          txt.join.html_safe
        else
          '<span class="empty">Empty</span>'.html_safe
        end
      end
    end
  end

end
