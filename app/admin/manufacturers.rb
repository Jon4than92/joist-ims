ActiveAdmin.register Manufacturer do
  menu parent: 'Lists', priority: 4, if: proc { current_account.account_type.name != 'Standard' }

  permit_params :name

  config.sort_order = 'id_desc'
  controller do
    before_save do |manufacturer|
      manufacturer.created_by_id = current_account.employee_id if manufacturer.new_record?
      manufacturer.updated_by_id = current_account.employee_id if !manufacturer.new_record?
    end

    before_action :check_account_type, action: :all
    def check_account_type
      if current_account.account_type.name == 'Standard'
        flash[:error] = 'You don\'t have access to that page.'
        redirect_to admin_employee_path(current_account)
      end
    end
  end

  index do
    selectable_column
    column 'Name' do |manufacturer|
      link_to manufacturer.name, admin_manufacturer_path(manufacturer)
    end
    column :created_at
    column :updated_at
    column 'Created by' do |manufacturer|
      manufacturer.created_by_id? ? link_to(manufacturer.created_by.full_name, admin_employee_path(manufacturer.created_by)) : ''
    end
    column 'Updated by' do |manufacturer|
      manufacturer.updated_by_id? ? link_to(manufacturer.updated_by.full_name, admin_employee_path(manufacturer.updated_by)) : ''
    end
    actions
  end

  filter :name_cont, label: 'Name'
  filter :created_at_or_updated_at, as: :date_range
  filter :updated_at, as: :date_range
  filter :created_by_first_name_or_created_by_middle_initial_or_created_by_last_name_cont, label: 'Created by'
  filter :updated_by_first_name_or_created_by_middle_initial_or_created_by_last_name_cont, label: 'Updated by'

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name, required: true
    end
    f.actions
  end

  show do
    attributes_table title: 'Manufacturer' do
      row :name
    end

    attributes_table title: 'Metadata' do
      row 'Created by' do |manufacturer|
        txt = []
        txt << (manufacturer.created_by_id? ? link_to(manufacturer.created_by.full_name, admin_employee_path(manufacturer.created_by)) : '<strong>Deleted User</strong>')
        txt << " on #{manufacturer.created_at.in_time_zone('Central Time (US & Canada)').strftime("%B %d, %Y (%I:%M%P)")}"
        txt.join.html_safe
      end
      row 'Last updated by' do |manufacturer|
        if manufacturer.updated_by_id?
          txt = []
          txt << link_to(manufacturer.updated_by.full_name, admin_employee_path(manufacturer.updated_by))
          txt << " on #{manufacturer.updated_at.in_time_zone('Central Time (US & Canada)').strftime("%B %d, %Y (%I:%M%P)")}"
          txt.join.html_safe
        else
          '<span class="empty">Empty</span>'.html_safe
        end
      end
    end
  end
end
