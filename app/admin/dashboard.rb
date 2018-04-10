ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: 'Dashboard'

  content title: 'Dashboard' do
    columns do
      column do
        panel 'Active/inactive software licenses' do
          data = [['Active', Software.where('license_end_date > ?', Date.today).count], ['Inactive', Software.where('license_end_date <= ?', Date.today).count]]
          pie_chart data, messages: { empty: 'No data' }
        end
      end
      column do
        panel 'Software license end dates by month' do
          column_chart Software.group_by_month(:license_end_date, series: false, format: '%B %Y').count, messages: { empty: 'No data' }
        end
      end
    end
  end
end
