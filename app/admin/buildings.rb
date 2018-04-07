ActiveAdmin.register Building do
  menu parent: 'Lists'

  permit_params :name

  config.per_page = 30
  config.sort_order = 'name_desc'
end
