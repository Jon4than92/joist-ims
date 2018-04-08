ActiveAdmin.register Vendor do
  menu parent: 'Lists'

  permit_params :name

  config.sort_order = 'id_desc'
end
