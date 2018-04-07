ActiveAdmin.register Room do
  menu parent: 'Lists'

  permit_params :name, :building_id

  config.per_page = 30
  config.sort_order = 'name_desc'
end