class AddLastUpdatedByToEmployees < ActiveRecord::Migration[5.1]
  def change
    add_column :employees, :last_updated_by, :bigint
  end
end
