class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :firstName, limit: 25, null: false
      t.string :middleInitial, limit: 1, null: false
      t.string :lastName, limit: 25, null: false
      t.string :jobTitle, limit: 50, null: false
      t.references :location, foreign_key: { on_update: :cascade, on_delete: :restrict }, null: false
      t.string :email, limit: 75, null: false
      t.string :phone, limit: 15, null: false
      t.boolean :active, default: true, null: false

      t.timestamps
    end

    add_index :employees, :email, unique: true
  end
end
