ActiveAdmin.register Employee do
  config.per_page = 30
  permit_params :first_name, :middle_initial, :last_name, :job_title, :room_id, :email, :phone, :active, custodian_account_ids: [],
                rooms_attributes: [:id, :building_id, :name, :_destroy],
                buildings_attributes: [:id, :name, :_destroy],
                account_attributes: [:id, :employee_id, :account_type_id, :email, :password, :password_confirmation, :_destroy],
                account_types_attributes: [:id, :name, :_destroy],
                custodians_attributes: [:id, :employee_id, :custodian_account_id, :_destroy]

  config.sort_order = 'id_desc'

  controller do
    def scoped_collection
      end_of_association_chain.includes(custodians: :custodian_account, room: :building, account: :account_type)
    end
  end

  index do
    selectable_column
    column :last_name
    column :first_name
    column :email
    column :phone
    column 'Building', sortable: 'buildings.name' do |employee|
      employee.room.building.name
    end
    column 'Room', sortable: 'rooms.name' do |employee|
      employee.room.name
    end
    actions
  end

  filter :first_name_cont, label: 'First name'
  filter :last_name_cont, label: 'Last name'
  filter :email_cont, label: 'Email'
  filter :phone_cont, label: 'Phone'
  filter :room_name_cont, as: :string, label: 'Room'
  filter :room_building_name_cont, as: :string, label: 'Building'
  filter :active, as: :check_boxes, collection: [['Inactive account', false]], label: ''

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :first_name, required: true
      f.input :middle_initial
      f.input :last_name, required: true
      f.input :job_title, required: true
      if f.object.new_record?
        f.input :email, required: true, placeholder: 'me@example.com', :as => :email
      else
        f.input :email, input_html: { disabled: true, readonly: true }
      end
      f.input :phone, required: true, placeholder: '123-456-7890', :as => :phone
      f.input :room_id, label: 'Location', as: :select, collection: Room.all.map{|u| ["#{u.building.name}.#{u.name}", u.id]}
=begin
      f.input :room_id, required: true, as: :nested_select,
                        level_1: {
                          attribute: :building_id,
                          collection: Building.all
                        },
                        level_2: {
                          attribute: :room_id,
                          collection: Room.all
                        }
=end
      f.fields_for :account, f.object.account || f.object.build_account do |a|
        a.input :account_type_id, label: 'Account type', as: :select, collection: AccountType.all.map{|u| [u.name, u.id]}, required: true
      end
      f.input :custodian_account_ids, label: 'Custodian accounts', as: :select, multiple: true, collection: CustodianAccount.all.map{|u| [u.name, u.id]}
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
        e.room.building.name
      end
      row 'Room' do
        e.room.name
      end
      row 'Account type' do
        e.account.account_type.name
      end
      if e.account.account_type.name == 'Custodian'
        row :custodian_accounts
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