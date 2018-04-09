class CreateHardware < ActiveRecord::Migration[5.1]
  def change
    create_table :hardware do |t|
      t.string :name, limit: 75, null: false
      t.references :manufacturer, foreign_key: { on_update: :cascade, on_delete: :restrict }, null: false
      t.integer :year, null: false
      t.string :model_num, limit: 50, null: false
      t.string :tag_num, limit: 50, null: false
      t.string :serial_num, limit: 50, null: false
      t.decimal :cost, precision: 10, scale: 2, null: false
      t.string :condition, limit: 25, null: false
      t.text :notes
      t.references :room, foreign_key: { on_update: :cascade, on_delete: :nullify }, null: false
      t.date :assigned_date
      t.references :custodian, foreign_key: { on_update: :cascade, on_delete: :nullify }

      t.timestamps
    end

    add_reference :hardware, :assigned_to_id, foreign_key: { to_table: :employees, on_update: :cascade, on_delete: :nullify }
    add_reference :hardware, :updated_by_id, foreign_key: { to_table: :employees, on_update: :cascade, on_delete: :nullify }
    add_reference :hardware, :created_by_id, foreign_key: { to_table: :employees, on_update: :cascade, on_delete: :nullify }
    add_index :hardware, :tag_num, unique: true
    add_index :hardware, :serial_num, unique: true
  end
end