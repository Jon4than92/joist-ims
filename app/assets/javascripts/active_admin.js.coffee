#= require active_admin/base
#= require activeadmin_addons/all

$(document).on 'ready page:load', ->
  initSelect2($(".select-input"), placeholder: "")
return
