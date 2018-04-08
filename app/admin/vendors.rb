ActiveAdmin.register Vendor do
  menu parent: 'Lists', priority: 3

  permit_params :name

  config.sort_order = 'id_desc'
end
