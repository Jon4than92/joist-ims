ActiveAdmin.register Custodian do
  menu parent: 'Lists', priority: 1

  permit_params :employee_id, :custodian_account_id

  config.sort_order = 'id_asc'
end