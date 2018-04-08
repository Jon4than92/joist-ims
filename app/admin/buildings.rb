ActiveAdmin.register Building do
  menu parent: 'Lists', priority: 6

  permit_params :name

  config.sort_order = 'name_desc'
end
