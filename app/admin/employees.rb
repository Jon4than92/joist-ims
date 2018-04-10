ActiveAdmin.register Employee do
  #menu  :if => proc{ current_account.account_type.name == 'Standard' }, label: 'Employees test'
  permit_params :first_name, :middle_initial, :last_name, :job_title, :room_id, :email, :phone, :active, custodian_account_ids: [],
                rooms_attributes: [:id, :building_id, :name, :_destroy],
                buildings_attributes: [:id, :name, :_destroy],
                account_attributes: [:id, :employee_id, :account_type_id, :email, :password, :password_confirmation, :_destroy],
                account_types_attributes: [:id, :name, :_destroy],
                custodians_attributes: [:id, :employee_id, :custodian_account_id, :_destroy]

  config.sort_order = 'last_name_desc'

  controller do
    def scoped_collection
      end_of_association_chain.includes(custodians: :custodian_account, room: :building, account: :account_type)
    end
  end

  #scope_to :current_account, if: proc{ current_account.account_type.name == 'Standard' }
 # scope_to :current_account, unless: proc{ current_account.account_type.name == 'Custodian' || current_account.account_type.name == 'Management' }

  index do
  if current_account.account_type.name == 'Standard'
    column :full_name do |employee|
      link_to employee.full_name, admin_employee_path(employee)
    end
    column :email
    column :job_title
    column :phone
    column 'Building', sortable: 'buildings.name' do |employee|
      link_to employee.room.building.name, admin_building_path(employee.room.building)
    end
    column 'Room', sortable: 'rooms.name' do |employee|
      link_to employee.room.name, admin_room_path(employee.room)
    end
  else
    selectable_column
      column :full_name do |employee|
        link_to employee.full_name, admin_employee_path(employee)
      end
      column :email
      column :job_title
      column :phone
      column 'Building', sortable: 'buildings.name' do |employee|
        link_to employee.room.building.name, admin_building_path(employee.room.building)
      end
      column 'Room', sortable: 'rooms.name' do |employee|
        link_to employee.room.name, admin_room_path(employee.room)
      end
      actions
    end
  end

  filter :first_name_or_middle_initial_or_last_name_cont, label: 'Name'
  filter :job_title_cont, label: 'Job title'
  filter :email_cont, label: 'Email'
  filter :phone_cont, label: 'Phone'
  filter :room_name_cont, as: :string, label: 'Room'
  filter :room_building_name_cont, as: :string, label: 'Building'
  filter :active, as: :check_boxes, collection: [['Inactive account', false]], label: '',
         if: proc{ current_account.account_type.name == 'Custodian' || current_account.account_type.name == 'Management' }
  filter :created_at, as: :date_range,
        if: proc{ current_account.account_type.name == 'Custodian' || current_account.account_type.name == 'Management' }
  #filter :created_by_cont, label: 'Created by'
  filter :updated_at, as: :date_range,
         if: proc{ current_account.account_type.name == 'Custodian' || current_account.account_type.name == 'Management' }
  #filter :updated_by_cont, label: 'Updated by'

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :first_name, required: true
      f.input :middle_initial
      f.input :last_name, required: true
      f.input :job_title, required: true
      if f.object.new_record?
        f.input :email, required: true, as: :email, hint: 'Required format: email@domain.com'
      else
        f.input :email, input_html: { disabled: true, readonly: true }
      end
      f.input :phone, as: :phone, hint: 'Required format: ###-###-####', required: true
      f.input :room_id, required: true, as: :nested_select,
                        level_1: { attribute: :building_id, collection: Building.all },
                        level_2: { attribute: :room_id, collection: Room.all }
      f.fields_for :account, f.object.account || f.object.build_account do |a|
        a.input :account_type_id, label: 'Account type', as: :select, collection: AccountType.all.map{|u| [u.name, u.id]}, required: true
        if a.object.new_record?
        else
          a.input :password
          a.input :password_confirmation
        end
      end
      f.input :custodian_account_ids, label: 'Custodian accounts', as: :select, multiple: true, collection: CustodianAccount.all.map{|u| [u.name, u.id]}, hint: 'Ctrl+Click to select multiple accounts'
      f.input :active, required: true
    end
    f.actions
  end

  show do |e|
      attributes_table title: 'Employee' do
      row :full_name
      row :job_title
      row :email
      row :phone, as: :phone
      row 'Building' do |employee|
        link_to employee.room.building.name, admin_building_path(employee.room.building)
      end
      row 'Room' do |employee|
        link_to employee.room.name, admin_room_path(employee.room)
      end
      row 'Account type' do |employee|
        employee.account.account_type.name
      end
      if e.account.account_type.name == 'Custodian'
        row 'Custodian accounts' do |employee|
          custodian_list = employee.custodians.map { |c| link_to c.custodian_account.name, admin_custodian_path(c) }
          safe_join custodian_list, ', '
        end
      end
      row :active
    end

    attributes_table title: 'Account' do
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

    attributes_table title: 'Metadata' do
      row :created_at
      row :updated_at
    end
  end

end