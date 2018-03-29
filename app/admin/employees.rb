ActiveAdmin.register Employee do
  permit_params :first_name, :middle_initial, :last_name, :job_title, :email, :phone, :location_id,
                locations_attributes: [:id, :room, :_destroy],
                buildings_attributes: [:id, :name, :_destroy],
                account_attributes: [:id, :account_type_id, :password, :password_confirmation, :_destroy],
                account_types_attributes: [:id, :name, :_destroy]

  config.sort_order = 'id_desc'

  controller do
    def scoped_collection
      end_of_association_chain.includes(location: :building, account: :account_type)
    end
  end

  index do
    selectable_column
    column :last_name
    column :first_name
    column :email
    column :phone
    column 'Building', sortable: 'buildings.name' do |employee|
      employee.location.building.name
    end
    column 'Room', sortable: 'locations.room' do |employee|
      employee.location.room
    end
    actions
  end

  filter :first_name_cont, label: 'First name'
  filter :last_name_cont, label: 'Last name'
  filter :email_cont, label: 'Email'
  filter :phone_cont, label: 'Phone'
  filter :location_room_cont, as: :string, label: 'Room'
  filter :location_building_name_cont, as: :string, label: 'Building'

  form do |f|
    f.inputs 'Employee' do
      f.input :first_name
      f.input :middle_initial
      f.input :last_name
      f.input :job_title
      f.input :email
      f.input :phone
      f.input :location_id, label: 'Location', as: :select, collection: Location.all.map{|u| ["#{u.building.name}.#{u.room}", u.id]}
      f.fields_for :account, Account.new do |a|
        a.input :account_type_id, label: 'Account type', as: :select, collection: AccountType.all.map{|u| [u.name, u.id]}
        a.input :password
        a.input :password_confirmation
      end
    end
    f.actions
  end

end
