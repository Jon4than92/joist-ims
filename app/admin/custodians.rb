ActiveAdmin.register Custodian do
  menu parent: 'Lists'

  permit_params :employee_id, :custodian_account_id

  config.per_page = 30
  config.sort_order = 'id_asc'
end