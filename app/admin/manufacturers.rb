ActiveAdmin.register Manufacturer do
  menu parent: 'Lists', priority: 4

  permit_params :name

  config.sort_order = 'id_desc'
end
