class CreateCustodianAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :custodian_accounts do |t|
      t.string :name, limit: 10, null: false

      t.timestamps
    end

    add_index :custodian_accounts, :name, unique: true
  end
end
