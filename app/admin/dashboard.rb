ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: 'Dashboard'

  content title: 'Dashboard' do
    columns do
      column do
        panel 'Software license end dates by month' do
          column_chart Software.group_by_month(:license_end_date, series: false, format: '%B %Y').count, messages: { empty: 'No data' }
        end
      end
      column do
        panel 'Active/inactive software licenses' do
          pie_chart Software.group(:active).count, messages: { empty: 'No data' }
        end
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
