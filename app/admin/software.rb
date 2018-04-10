ActiveAdmin.register Software do
  permit_params :name, :vendor_id, :version, :year, :employee_id, :assigned_date, :license_start_date, :license_end_date, :hardware_id, :custodian_id, :active

  config.sort_order = 'license_end_date_asc'

  scope :all, default: :true
  scope :active do |software|
    software.where('license_end_date > ?', Date.today)
  end
  scope :license_valid do |software|
    software.where('license_end_date > ?', Date.today + 3.months)
  end
  scope :expiring_soon do |software|
    software.where('license_end_date > ? and license_end_date <= ?', Date.today + 1.month, Date.today + 3.months)
  end
  scope :renewal_urgent do |software|
    software.where('license_end_date <= ? and license_end_date > ?', Date.today + 1.month, Date.today)
  end
  scope :license_expired do |software|
    software.where('license_end_date <= ?', Date.today)
  end

  index do
    config.default_per_page = 1
    selectable_column
    column :name do |software|
      link_to software.name, admin_software_path(software)
    end
    column 'Vendor', sortable: 'vendors.name' do |software|
      link_to software.vendor.name, admin_vendor_path(software.vendor)
    end
    column :version
    column :year
    column :license_start_date
    column :license_end_date
    column 'License Status' do |software|
      status_tag software.set_expiration_status
    end
    if params[:scope] != 'license_expired' and params[:scope] != 'all'
      column 'Days Remaining' do |software|
        if software.calc_time_remaining > 0
          "#{software.calc_time_remaining} days"
        else
          '--'
        end
      end
    end
    column 'Assigned Hardware', sortable: 'hardware.name' do |software|
      if software.hardware_id?
        link_to software.hardware.name, admin_hardware_path(software.hardware)
      else
        '--'
      end
    end
    actions
  end

  filter :name_cont, label: 'Name'
  filter :license_start_date_and_license_end_date, label: 'License date range', as: :date_range
#  filter :active, as: :check_boxes, collection: [['Active', false]], label: ''

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name, required: true
      f.input :vendor_id, label: 'Vendor', as: :select, collection: Vendor.all.map{|u| [u.name, u.id]}, required: true
      f.input :version, required: true
      f.input :year, required: true
      f.input :license_start_date, as: :datepicker, datepicker_options: { min_date: 1.year.ago.to_date }
      f.input :license_end_date, as: :datepicker, datepicker_options: { min_date: :license_start_date.to_s }
      f.input :hardware_id, label: 'Installed on hardware', as: :select, collection: Hardware.all.map{|u| [u.name, u.id]}
      f.input :assigned_to_id, label: 'Assigned to employee', as: :select, collection: Employee.all.map{|u| ["#{u.full_name}", u.id]}
      f.input :custodian_id, label: 'Assigned to custodian', as: :select, collection: Custodian.all.map{|u| ["#{u.employee.full_name}, #{u.custodian_account.name}", u.id]}
      f.input :active, required: true
      if f.object.new_record?
        f.input :created_by_id, as: :hidden, input_html: { value: current_account.employee_id }
      else
        f.input :updated_by_id, as: :hidden, input_html: { value: current_account.employee_id }
      end
    end
    f.actions
  end

  show do
    attributes_table title: 'Software' do
      row :name
      row 'Vendor' do |software|
        link_to software.vendor.name, admin_vendor_path(software.vendor)
      end
      row :version
      row :year
      row :license_start_date
      row :license_end_date
      row 'Installed on hardware' do |software|
        if software.hardware_id?
          link_to software.hardware.name, admin_hardware_path(software.hardware)
        else
          '<span class="empty">Empty</span>'.html_safe
        end
      end
      row 'Assigned to employee' do |software|
        if software.assigned_to_id?
          txt = []
          txt << link_to(software.assigned_to.full_name, admin_employee_path(software.assigned_to))
          txt << " on #{software.assigned_date.in_time_zone('Central Time (US & Canada)').strftime("%B %d, %Y")}"
          txt.join.html_safe
        else
          '<span class="empty">Empty</span>'.html_safe
        end
      end
      row 'Assigned to custodian' do |software|
        if software.custodian_id?
          link_to software.custodian.employee.full_name, admin_custodian_path(software.custodian.employee)
        else
          '<span class="empty">Empty</span>'.html_safe
        end
      end
      row :active
    end

    attributes_table title: 'Metadata' do
      row 'Created by' do |software|
        txt = []
        txt << (software.created_by_id? ? link_to(software.created_by.full_name, admin_employee_path(software.created_by)) : '<strong>Deleted User</strong>')
        txt << " on #{software.created_at.in_time_zone('Central Time (US & Canada)').strftime("%B %d, %Y (%I:%M%P)")}"
        txt.join.html_safe
      end
      row 'Last updated by' do |software|
        if software.updated_by_id?
          txt = []
          txt << link_to(software.updated_by.full_name, admin_employee_path(software.updated_by))
          txt << " on #{software.updated_at.in_time_zone('Central Time (US & Canada)').strftime("%B %d, %Y (%I:%M%P)")}"
          txt.join.html_safe
        else
          '<span class="empty">Empty</span>'.html_safe
        end
      end
    end
  end

end
