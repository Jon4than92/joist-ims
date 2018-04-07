ActiveAdmin.register Hardware do
  permit_params :name, :manufacturer_id, :year, :model_num, :tag_num, :serial_num, :cost, :condition, :notes, :room_id, :employee_id, :assigned_date, :custodian_id

  config.sort_order = 'id_desc'
  config.per_page = 30

  controller do
    def scoped_collection
      end_of_association_chain.includes(room: :building)
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
  #filter :employee_first_name_cont, label: 'Assigned to (first name)'
  #filter :employee_last_name_cont, label: 'Assigned to (last name)'
  filter :assigned_date, as: :date_range
  #filter :custodian_employee_first_name_cont, label: 'Custodian (first name)'
  #filter :custodian_employee_last_name_cont, label: 'Custodian (last name)'
  #filter :custodian_custodian_account_name_cont, label: 'Custodian account'

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name, required: true
      f.input :manufacturer_id, label: 'Manufacturer', as: :select, collection: Manufacturer.all.map{|u| [u.name, u.id]}, required: true
      f.input :year, required: true
      f.input :model_num, required: true
      f.input :tag_num, required: true
      f.input :serial_num, required: true
      f.input :cost, label: 'Cost ($)', required: true
      f.input :condition, required: true
      f.input :room_id, label: 'Room', as: :select, collection: Room.all.map{|u| ["#{u.building.name}.#{u.name}", u.id]}, required: true
      f.input :employee_id, label: 'Assigned to employee', as: :select, collection: Employee.all.map{|u| [u.full_name, u.id]}
      f.input :assigned_date, as: :datepicker, input_html: { placeholder: Date.today }
      f.input :custodian_id, label: 'Assigned to custodian', as: :select, collection: Custodian.all.map{|u| ["#{u.employee.full_name}, #{u.custodian_account.name}", u.id]}
      f.input :notes, input_html: { rows: 8 }
    end
    f.actions
  end

  show do
    attributes_table :title => 'Hardware' do
      row :name
      row 'Manufacturer' do |hardware|
        link_to hardware.manufacturer.name, admin_manufacturer_path(hardware.manufacturer)
      end
      row :year
      row :model_num
      row :tag_num
      row :serial_num
      row 'Cost ($)' do |hardware|
        hardware.cost
      end
      row :condition
      row 'Building' do |hardware|
        link_to hardware.room.building.name, admin_building_path(hardware.room.building)
      end
      row 'Room' do |hardware|
        link_to hardware.room.name, admin_room_path(hardware.room)
      end
=begin
      row 'Assigned to employee' do |hardware|
        link_to hardware.employee.first_name, admin_employee_path(hardware.employee)
      end
      row :assigned_date
      row 'Assigned to custodian' do |hardware|
        link_to hardware.custodian.employee.first_name, admin_custodian_path(hardware.custodian.employee)
      end
=end
      row :notes
    end

    attributes_table :title => 'Metadata' do
      row :created_at
      row :updated_at
    end
  end

end
