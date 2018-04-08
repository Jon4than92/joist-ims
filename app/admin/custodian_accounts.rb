ActiveAdmin.register CustodianAccount do
  menu parent: 'Lists', priority: 2

  permit_params :name

  config.sort_order = 'name_desc'
end