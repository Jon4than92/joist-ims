class CreateHardware < ActiveRecord::Migration[5.1]
  def change
    create_table :hardware do |t|
      t.string :name, limit: 75, null: false
      t.references :manufacturer, foreign_key: { on_update: :cascade, on_delete: :restrict }, null: false
      t.integer :year, null: false
      t.string :modelNum, limit: 50, null: false
      t.integer :tagNum, null: false
      t.string :serialNum, limit: 50, null: false
      t.numeric :cost, precision: 2, null: false
      t.string :condition, limit: 25, null: false
      t.text :notes
      t.references :location, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.references :assignedTo, references: :employee
      t.date :assignedDate
      t.references :custodian, foreign_key: { on_update: :cascade, on_delete: :nullify }

      t.timestamps
    end

    add_foreign_key :hardware, :employees, column: :assignedTo_id, on_update: :cascade, on_delete: :nullify
    add_index :hardware, :tagNum, unique: true
    add_index :hardware, :serialNum, unique: true
  end

  def up
    execute "ALTER TABLE hardware ADD CONSTRAINT hardware_year_limit CHECK (year <= date_part('year', CURRENT_DATE))"
  end

  def down
    execute 'ALTER TABLE hardware DROP CONSTRAINT hardware_year_limit'
  end
end