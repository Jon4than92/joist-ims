class AddLastUpdatedByToHardware < ActiveRecord::Migration[5.1]
  def change
    add_column :hardware, :last_updated_by, :bigint
  end
end
