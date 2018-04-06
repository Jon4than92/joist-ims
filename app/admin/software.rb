ActiveAdmin.register Software do
  permit_params :name, :vendor_id, :version, :year, :assigned_to_id, :assigned_date, :license_start_date, :license_end_date, :hardware_id, :custodian_id, :active

  config.sort_order = 'license_end_date_asc',

#  controller do
#    scope :all, :default => true
#    scope :expiring_soon do |software|
#      software.where('due_date > ? and due_date < ?', Date.today, 1.month.from_now)
#    end
#    scope :late do |tasks|
#      tasks.where('due_date < ?', Time.now)
#    end
#    scope :mine do |tasks|
#      tasks.where(:admin_user_id => current_admin_user.id)
#    end
#  end

  index do
    selectable_column
    column :name do |software|
      link_to software.name, admin_software_path(software)
    end
    column 'Vendor', sortable: 'vendors.name' do |software|
      link_to software.vendor.name, admin_vendor_path(software.vendor)
    end
    column :version
    column :year
#    column 'Assigned to Employee', :assigned_to_id do |software|
#      link_to software.employees.first_name, admin_employees_path(software.employees)
#    end
#    column :assigned_date

    column :license_start_date
    column :license_end_date

    column 'License Status' do |software|
      status_tag software.set_expiration_status
    end

#    column('License Status') { |license| status_tag (license.is_done ? "RENEWAL REQUIRED" : "EXPIRING SOON"), (license.is_done ? :ok : :error) }

    column 'Assigned Hardware', sortable: 'hardware.name' do |software|
      software.hardware.name
    end
#    column :custodian_id - need assigned custodian + account here - JO
    actions
  end

  filter :name_cont, label: 'Name'
  filter :license_start_date, label: 'License Start Date'
  filter :license_end_date, label: 'License End Date'
  filter :active, as: :check_boxes, collection: [['Show Expired Licenses?', false]], label: ''

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name, required: true
      f.input :vendor_id, label: 'Vendor', as: :select, collection: Vendor.all.map{|u| [u.name, u.id]}, required: true
      f.input :version, required: true
      f.input :year, required: true
      f.input :assigned_to_id, label: 'Assigned to Employee', as: :select, collection: Employee.all.map{|u| ["#{u.full_name}", u.id]}
      f.input :assigned_date, as: :datepicker, input_html: { placeholder: Date.today() }, required: true

      f.input :license_start_date, as: :datepicker, datepicker_options: {
          min_date: 3.months.ago.to_date,
      }, required: true

      f.input :license_end_date, as: :datepicker, datepicker_options: {
          min_date: :license_start_date.to_s,
      }, required: true
      f.input :hardware_id, as: :select, collection: Hardware.all.map{|u| ["#{u.name}", u.id]}
      f.input :custodian_id, label: 'Assigned to custodian', as: :select, collection: Custodian.all.map{|u| ["#{u.employee.full_name}, #{u.custodian_account.name}", u.id]}
      f.input :active, required: true if !f.object.new_record?
    end
    f.actions
  end


# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
