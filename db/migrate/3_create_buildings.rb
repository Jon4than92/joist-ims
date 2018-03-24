class CreateBuildings < ActiveRecord::Migration[5.1]
  def change
    create_table :buildings do |t|
      t.string :name, limit: 10, null: false

      t.timestamps
    end

    add_index :buildings, :name, unique: true
  end
end
