class CreateCustodians < ActiveRecord::Migration[5.1]
  def change
    create_table :custodians do |t|
      t.references :employee, foreign_key: { on_update: :cascade, on_delete: :cascade }, null: false
      t.references :custodian_account, foreign_key: { on_update: :cascade, on_delete: :cascade }, null: false

      t.timestamps
    end
  end
end
