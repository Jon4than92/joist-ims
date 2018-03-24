class CreateManufacturers < ActiveRecord::Migration[5.1]
  def change
    create_table :manufacturers do |t|
      t.string :name, limit: 75, null: false

      t.timestamps
    end

    add_index :manufacturers, :name, unique: true
  end
end
