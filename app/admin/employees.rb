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
  filter :active, as: :check_boxes, collection: [['Inactive account', false]], label: ''

  form do |f|
    f.inputs 'Employee' do
      f.input :first_name, required: true
      f.input :middle_initial
      f.input :last_name, required: true
      f.input :job_title, required: true
      if f.object.new_record?
        f.input :email, required: true
      else
        f.input :email, input_html: { disabled: true, readonly: true }
      end
      f.input :phone, required: true
      f.input :location_id, label: 'Location', as: :select, collection: Location.all.map{|u| ["#{u.building.name}.#{u.room}", u.id]}, required: true
      f.fields_for :account, Account.new do |a|
        a.input :account_type_id, label: 'Account type', as: :select, collection: AccountType.all.map{|u| [u.name, u.id]}, required: true
      end
      f.input :active, required: true if !f.object.new_record?
    end
    f.actions
  end

  show do |e|
    attributes_table :title => 'Employee' do
      row :full_name
      row :job_title
      row :email
      row :phone
      row 'Building' do
        e.location.building.name
      end
      row 'Room' do
        e.location.room
      end
      row 'Account type' do
        e.account.account_type.name
      end
      row :active
    end

    attributes_table :title => 'Account' do
      row 'Last sign in' do
        e.account.last_sign_in_at
      end
      row 'Current sign in' do
        e.account.current_sign_in_at
      end
      row 'Last sign in IP' do
        e.account.last_sign_in_ip
      end
      row 'Current sign in IP' do
        e.account.last_sign_in_ip
      end
    end
  end

end