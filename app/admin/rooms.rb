ActiveAdmin.register Room do
  menu parent: 'Lists', priority: 5

  permit_params :name, :building_id

  config.sort_order = 'name_desc'
end