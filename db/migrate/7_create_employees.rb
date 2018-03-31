class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :first_name, limit: 25, null: false
      t.string :middle_initial, limit: 1, null: false
      t.string :last_name, limit: 25, null: false
      t.string :job_title, limit: 50, null: false
      t.references :room, foreign_key: { on_update: :cascade, on_delete: :restrict }, null: false
      t.string :email, limit: 75, null: false
      t.string :phone, limit: 15, null: false
      t.boolean :active, default: true, null: false

      t.timestamps
    end

    add_index :employees, :email, unique: true
  end
end
