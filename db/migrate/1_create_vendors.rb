class CreateVendors < ActiveRecord::Migration[5.1]
  def change
    create_table :vendors do |t|
      t.string :name, limit: 75, null: false

      t.timestamps
    end

    add_index :vendors, :name, unique: true
  end
end
