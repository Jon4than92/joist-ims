ActiveAdmin.register Account do
  permit_params :id, :password, :password_confirmation, :new_password, :new_password_confirmation

  menu false

  actions :index, :edit, :update

  config.clear_action_items!

  controller do
    before_action :no_index, only: :index
    def no_index
      redirect_to profile_admin_employee_path(current_account.employee)
    end

    before_action :check_user, only: [:edit, :update]
    def check_user
      if current_account.id != params[:id].to_i
        redirect_to edit_admin_account_path(current_account)
      end
    end
  end

  index do
    column 'Employee Name', sortable: 'employee.full_name' do |account|
      account.employee.full_name
    end
    column :email
    column :sign_in_count
    column :current_sign_in_at
    column :last_sign_in_at
    column :created_at
    column :updated_at
  end

  filter :employee_first_name_and_employee_middle_initial_and_employee_last_name_cont, label: 'Employee Name'
  filter :email_cont, label: 'Email'
  filter :sign_in_count, as: :numeric_range_filter
  filter :current_sign_in_at, as: :date_range
  filter :last_sign_in_at, as: :date_range
  filter :created_at, as: :date_range
  filter :updated_at, as: :date_range

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :password, label: 'Current password', required: true
      f.input :password_confirmation, label: 'Retype current password', required: true
      f.input :new_password, required: true, hint: 'Must contain at least 8 characters including a lowercase letter, an uppercase letter, and a symbol'
      f.input :new_password_confirmation, label: 'Retype new password', required: true
    end
    f.actions
  end
end