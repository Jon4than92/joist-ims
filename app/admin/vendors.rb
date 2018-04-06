ActiveAdmin.register Vendor do

  permit_params :name
  config.per_page = 30
  config.sort_order = 'id_desc'

end
