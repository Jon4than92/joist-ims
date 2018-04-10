ActiveAdmin.register CustodianAccount do
  menu parent: 'Lists', priority: 2

  permit_params :name,
                custodian_attributes: [:id, :employee_id, :_destroy]


  config.sort_order = 'name_desc'
end