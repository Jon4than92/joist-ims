ActiveAdmin.register Employee do
  permit_params :first_name, :middle_initial, :last_name, :job_title, :email, :phone,
                locations_attributes: [:id, :room, :_destroy],
                buildings_attributes: [:id, :name, :_destroy],
                accounts_atributes: [:id, :employee_id, :account_type_id, :email, :password, :password_confirmation, :_destroy]
  config.sort_order = 'id_desc'

  controller do
    def scoped_collection
      end_of_association_chain.includes(:location)
    end
  end

  index do
    selectable_column
    id_column
    column :last_name
    column :first_name
    column :email
    column :phone
    column 'Building', :building
    column 'Room', :room
    actions
  end

  filter :first_name
  filter :last_name
  filter :email
  filter :phone
  filter :location_room, as: :string, label: 'Room'
  filter :location_building_name, as: :string, label: 'Building'

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
    f.actions
  end

end
