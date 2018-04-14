ActiveAdmin.register Employee do
  permit_params :id, :first_name, :middle_initial, :last_name, :job_title, :room_id, :email, :phone, :active, custodian_account_ids: [],
                rooms_attributes: [:id, :building_id, :name, :_destroy],
                buildings_attributes: [:id, :name, :_destroy],
                account_attributes: [:id, :employee_id, :account_type_id, :email, :password, :password_confirmation, :_destroy],
                account_types_attributes: [:id, :name, :_destroy],
                custodians_attributes: [:id, :employee_id, :custodian_account_id, :_destroy]

  config.sort_order = 'last_name_desc'

  member_action :profile do
    @employee = current_account.employee
    @hardware = Hardware.where('assigned_to_id = ?', @employee.id)
    @software = Software.where('assigned_to_id = ?', @employee.id)
  end

  controller do
    def scoped_collection
      end_of_association_chain.includes(custodians: :custodian_account, room: :building, account: :account_type)
    end

    before_save do |employee|
      employee.created_by_id = current_account.employee_id if employee.new_record?
      employee.updated_by_id = current_account.employee_id if !employee.new_record?
    end

    before_action :check_account_type, only: [:new, :edit, :update, :destroy]
    def check_account_type
      if current_account.account_type.name == 'Standard'
        flash[:error] = 'You don\'t have access to that page.'
        redirect_to profile_admin_employee_path(current_account)
      end
    end

    #before_action :check_user_for_profile, only: :profile
    def check_user_for_profile
      if current_account.account_type.name == 'Standard' and current_account.employee_id != params[:id].to_i
        flash[:error] = 'You don\'t have access to that page.'
        redirect_to admin_profile_path(current_account)
      end
    end
  end

  index do
    if current_account.account_type.name == 'Standard'
      column 'Name', sortable: 'employee.full_name' do |employee|
        employee.full_name
      end
      column 'Email', sortable: 'employee.email' do |employee|
        mail_to (employee.email)
      end
      column :job_title
      column :phone
      column 'Building', sortable: 'buildings.name' do |employee|
        employee.room.building.name
      end
      column 'Room', sortable: 'rooms.name' do |employee|
        employee.room.name
      end
    else
      selectable_column
      column :full_name do |employee|
        link_to employee.full_name, admin_employee_path(employee)
      end
      column 'Email' do |employee|
        mail_to (employee.email)
      end
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
  filter :room_name_cont, label: 'Room'
  filter :room_building_name_cont, label: 'Building'
  filter :active, as: :blaze_toggle,  input_html: { toggle_class: 'c-toggle--brand' }, collection: [['Inactive account', false]], label: 'Show Inactive Employees?',
         if: proc { current_account.account_type.name != 'Standard' }
  filter :created_at, as: :date_range,
         if: proc { current_account.account_type.name != 'Standard' }
  filter :updated_at, as: :date_range,
         if: proc { current_account.account_type.name != 'Standard' }
  filter :created_by_first_name_or_created_by_middle_initial_or_created_by_last_name_cont, label: 'Created by',
         if: proc { current_account.account_type.name != 'Standard' }
  filter :updated_by_first_name_or_created_by_middle_initial_or_created_by_last_name_cont, label: 'Updated by',
         if: proc { current_account.account_type.name != 'Standard' }

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
    f.input :first_name, required: true
    f.input :middle_initial, required: false
    f.input :last_name, required: true
    f.input :job_title, required: true
    if f.object.new_record?
      f.input :email, required: true, as: :email, hint: 'Required format: email@domain.com'
    else
      f.input :email, as: :email, input_html: { disabled: true, class: 'c-field' }
    end
    f.input :phone, as: :phone, hint: 'Required format: ###-###-####', required: true
    f.input :room_id, required: true, as: :nested_select,
                      level_1: { attribute: :building_id, collection: Building.all },
                      level_2: { attribute: :room_id, collection: Room.all }
    f.fields_for :account, f.object.account || f.object.build_account do |a|
      a.input :account_type_id, label: 'Account type', as: :select, collection: AccountType.all.map{|u| [u.name, u.id]}, required: true
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
      row :email do |employee|
        mail_to (employee.email)
      end
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
      row 'Created by' do |employee|
        txt = []
        txt << (employee.created_by_id? ? link_to(employee.created_by.full_name, admin_employee_path(employee.created_by)) : '<strong>Deleted User</strong>')
        txt << " on #{employee.created_at.in_time_zone('Central Time (US & Canada)').strftime("%B %d, %Y (%I:%M%P)")}"
        txt.join.html_safe
      end
      row 'Last updated by' do |employee|
        if employee.updated_by_id?
          txt = []
          txt << link_to(employee.updated_by.full_name, admin_employee_path(employee.updated_by))
          txt << " on #{employee.updated_at.in_time_zone('Central Time (US & Canada)').strftime("%B %d, %Y (%I:%M%P)")}"
          txt.join.html_safe
        else
          '<span class="empty">Empty</span>'.html_safe
        end
      end
    end
  end

end