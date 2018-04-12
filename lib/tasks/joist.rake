namespace :joist do
  desc 'Set old licenses as inactive'
  task check_licenses: :environment do
    Software.all.each do |software|
      if software.license_end_date <= Date.today
        software.active = false
        software.save(validate: false)
      end
    end
  end
end