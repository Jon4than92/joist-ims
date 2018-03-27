ActiveAdmin.register Employee do
  permit_params :first_name, :middle_initial, :last_name, :job_title, :email, :phone,
                locations_attributes: [:id, :room, :_destroy],
                accounts_atributes: [:id, :employee_id, :account_type_id, :email, :password, :password_confirmation, :_destroy]
  config.sort_order = 'id_desc'

  index do
    selectable_column
    id_column
    column :last_name
    column :first_name
    column :email
    column :phone
    column 'Location', :full_location
    actions
  end

  filter :first_name
  filter :last_name
  filter :email
  filter :phone

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :middle_initial
      f.input :last_name
      f.input :job_title
      f.input :email
      f.input :phone
      f.input :password
      f.input :password_confirmation
    end
    f.inputs do
      f.has_many :locations, heading: false, allow_destroy: true, new_record: true do |a|
        a.input :room
      end
    end
    f.actions
  end

end
