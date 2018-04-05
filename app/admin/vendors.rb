ActiveAdmin.register Vendor do

  permit_params :name

  config.sort_order = 'id_desc'

end
