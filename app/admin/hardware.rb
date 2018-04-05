ActiveAdmin.register Hardware do
  permit_params :name, :manufacturer_id, :year, :model_num, :tag_num, :serial_num, :cost, :condition, :notes, :room_id, :assigned_to_id, :assigned_date, :custodian_id
  config.sort_order = 'id_desc'

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
      f.input :cost, required: true
      f.input :condition, required: true
      f.input :notes, input_html: { rows: 8 }
      f.input :room_id, label: 'Room', as: :select, collection: Room.all.map{|u| ["#{u.building.name}.#{u.name}", u.id]}, required: true
      f.input :assigned_to_id, label: 'Assigned to employee', as: :select, collection: Employee.all.map{|u| ["#{u.full_name}", u.id]}, required: false
      f.input :assigned_date, as: :datepicker, input_html: { placeholder: Date.today }, required: false
      f.input :custodian_id, label: 'Assigned to custodian', as: :select, collection: Custodian.all.map{|u| ["#{u.employee.full_name}, #{u.custodian_account.name}", u.id]}, required: false
    end
    f.actions
  end

end
