ActiveAdmin.register Vendor do
  menu parent: 'Lists', priority: 3, if: proc { current_account.account_type.name != 'Standard' }

  permit_params :name

  config.sort_order = 'id_desc'
end
