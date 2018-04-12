ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: 'Dashboard', if: proc { current_account.account_type.name != 'Standard' }

  controller do
    before_action :check_account_type, action: :all
    def check_account_type
      if current_account.account_type.name == 'Standard'
        flash[:error] = 'You don\'t have access to that page.'
        redirect_to admin_employee_path(current_account)
      end
    end
  end

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

    columns do
      column do
        panel 'Total cost of hardware for current fiscal year' do
          fiscal_year_start = Date.new(Date.today.year, 1, 1)
          fiscal_year_end = Date.new(1.year.from_now.year, 12, 31)
          data = [['Hardware', Hardware.where('created_at BETWEEN ? AND ?', fiscal_year_start, fiscal_year_end).sum(:cost)], ['Software', Software.where('created_at BETWEEN ? AND ?', fiscal_year_start, fiscal_year_end).sum(:cost)]]
          pie_chart data, messages: { empty: 'No data' }
        end
      end
    end
  end
end
