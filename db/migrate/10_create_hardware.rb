class CreateHardware < ActiveRecord::Migration[5.1]
  def change
    create_table :hardware do |t|
      t.string :name, limit: 75, null: false
      t.references :manufacturer, foreign_key: { on_update: :cascade, on_delete: :restrict }, null: false
      t.integer :year, null: false
      t.string :model_num, limit: 50, null: false
      t.integer :tag_num, null: false
      t.string :serial_num, limit: 50, null: false
      t.numeric :cost, precision: 2, null: false
      t.string :condition, limit: 25, null: false
      t.date :service_date
      t.text :notes
      t.references :room, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.references :assigned_to, references: :employee
      t.date :assigned_date
      t.references :custodian, foreign_key: { on_update: :cascade, on_delete: :nullify }

      t.timestamps
    end

    add_foreign_key :hardware, :employees, column: :assigned_to_id, on_update: :cascade, on_delete: :nullify
    add_index :hardware, :tag_num, unique: true
    add_index :hardware, :serial_num, unique: true
  end

  def up
    execute "ALTER TABLE hardware ADD CONSTRAINT hardware_year_limit CHECK (year <= date_part('year', CURRENT_DATE))"
  end

  def down
    execute 'ALTER TABLE hardware DROP CONSTRAINT hardware_year_limit'
  end
end