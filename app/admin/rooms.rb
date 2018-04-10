ActiveAdmin.register Room do
  menu parent: 'Lists', priority: 5, if: proc { current_account.account_type.name != 'Standard' }

  permit_params :name, :building_id

  config.sort_order = 'name_desc'
end