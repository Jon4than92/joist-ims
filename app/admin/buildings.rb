ActiveAdmin.register Building do
  menu parent: 'Lists', priority: 6, if: proc { current_account.account_type.name != 'Standard' }

  permit_params :name

  config.sort_order = 'name_desc'
end
