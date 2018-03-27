Rails.application.routes.draw do
  devise_for :accounts, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
