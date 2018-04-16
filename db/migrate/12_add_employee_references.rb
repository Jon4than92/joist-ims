class AddEmployeeReferences < ActiveRecord::Migration[5.1]
  def change
    add_reference :vendors, :updated_by, foreign_key: { to_table: :employees, on_update: :cascade, on_delete: :nullify }
    add_reference :vendors, :created_by, foreign_key: { to_table: :employees, on_update: :cascade, on_delete: :nullify }

    add_reference :manufacturers, :updated_by, foreign_key: { to_table: :employees, on_update: :cascade, on_delete: :nullify }
    add_reference :manufacturers, :created_by, foreign_key: { to_table: :employees, on_update: :cascade, on_delete: :nullify }

    add_reference :buildings, :updated_by, foreign_key: { to_table: :employees, on_update: :cascade, on_delete: :nullify }
    add_reference :buildings, :created_by, foreign_key: { to_table: :employees, on_update: :cascade, on_delete: :nullify }

    add_reference :custodian_accounts, :updated_by, foreign_key: { to_table: :employees, on_update: :cascade, on_delete: :nullify }
    add_reference :custodian_accounts, :created_by, foreign_key: { to_table: :employees, on_update: :cascade, on_delete: :nullify }

    add_reference :rooms, :updated_by, foreign_key: { to_table: :employees, on_update: :cascade, on_delete: :nullify }
    add_reference :rooms, :created_by, foreign_key: { to_table: :employees, on_update: :cascade, on_delete: :nullify }

    add_reference :employees, :updated_by, foreign_key: { to_table: :employees, on_update: :cascade, on_delete: :nullify }
    add_reference :employees, :created_by, foreign_key: { to_table: :employees, on_update: :cascade, on_delete: :nullify }

    add_reference :custodians, :created_by, foreign_key: { to_table: :employees, on_update: :cascade, on_delete: :nullify }

    add_reference :hardware, :assigned_to, foreign_key: { to_table: :employees, on_update: :cascade, on_delete: :nullify }
    add_reference :hardware, :updated_by, foreign_key: { to_table: :employees, on_update: :cascade, on_delete: :nullify }
    add_reference :hardware, :created_by, foreign_key: { to_table: :employees, on_update: :cascade, on_delete: :nullify }

    add_reference :software, :assigned_to, foreign_key: { to_table: :employees, on_update: :cascade, on_delete: :nullify }
    add_reference :software, :updated_by, foreign_key: { to_table: :employees, on_update: :cascade, on_delete: :nullify }
    add_reference :software, :created_by, foreign_key: { to_table: :employees, on_update: :cascade, on_delete: :nullify }
  end
end