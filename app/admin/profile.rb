ActiveAdmin.register_page 'Profile' do
  menu if: proc { current_account.account_type.name == 'Standard' }

  content do

  end
end