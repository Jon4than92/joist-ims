ActiveAdmin.register Building do
  menu parent: 'Lists'

  permit_params :name

  config.sort_order = 'name_desc'
end
