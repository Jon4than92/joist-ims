ActiveAdmin.register Vendor do
  menu parent: 'Lists'

  permit_params :name

  config.per_page = 30
  config.sort_order = 'id_desc'
end
