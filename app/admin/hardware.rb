ActiveAdmin.register Hardware do

  permit_params :name, :manufacturer_id, :year, :model_num, :tag_num, :serial_num, :cost, :condition, :notes, :room_id, :assigned_to_id, :assigned_date, :custodian_id,
                manufacturers_attributes: [:id, :name, :_destroy],
                rooms_attributes: [:id, :building_id, :name, :_destroy],
                custodians_attributes: [:id, :employee_id, :custodian_account_id, :_destroy],
                buildings_attributes: [:id, :name, :_destroy]

  config.sort_order = 'id_desc'

  controller do
    def scoped_collection
      end_of_association_chain.includes(software: :vendor, room: :building, custodians: :custodian_account, employee: :custodians)
    end
  end

  index do
    selectable_column
    column :name
    column 'Manufacturer', sortable: 'manufacturer.name' do |hardware|
      hardware.manufacturers.name
    end
    column :year
    column :model_num
    column :tag_num
    column :serial_num
    column :cost
    column :condition
    column :notes
    column :room_id, 'Room', sortable: 'rooms.name' do |hardware|
      hardware.room.building
    end
    actions
  end

  filter :name_cont, label: 'Hardware Name'

  form do |f|
    f.inputs 'Hardware' do
      f.input :name

      f.input :manufacturer, label: 'Manufacturer', input_html: { class: "select2" }

#      if f.object.new_record?
#        f.fields_for :manufacturer, Manufacturer.new do |a|
#          a.input :name, label: 'Manufacture', as: :string, input_html: { class: "select2" }, required: true
#        end
#      else
#        f.fields_for :account do |a|
#          a.input :manufacturer, label: 'Manufacturer', input_html: { class: "select2" }
#        end
#      end

      f.input :year
      f.input :model_num
      f.input :tag_num
      f.input :serial_num
      f.input :cost
      f.input :condition
      f.input :notes
      f.input :room_id, label: 'Room', as: :select, collection: Room.all.map{|u| ["#{u.building.name}.#{u.name}", u.id]}
      f.input :assigned_to_id, label: 'Assigned to Employee:', as: :select, collection: Employee.all.map{|u| ["#{u.first_name} #{u.last_name}", u.id]}
      f.input :assigned_date, as: :datepicker, :input_html => { :value => Date.today()}
      f.input :custodian_id, label: 'Assigned to Custodian:', as: :select, collection: Custodian.all.map{|u| ["#{u.employee.first_name}", u.id]}
    end
    f.actions
  end

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

#      f.fields_for :account, Account.new do |a|
#  a.input :account_type_id, label: 'Account type', as: :select, collection: AccountType.all.map{|u| [u.name, u.id]}
#  a.input :password
#  a.input :password_confirmation
#end



# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
