ActiveAdmin.register CustodianAccount do
  menu parent: 'Lists', priority: 2, if: proc { current_account.account_type.name != 'Standard' }

  permit_params :name,
                custodian_attributes: [:id, :employee_id, :_destroy]


  config.sort_order = 'name_desc'
end