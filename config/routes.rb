OpenLists::Engine.routes.draw do
  resources :domain_lists


  scope '/:domain/:list_name' do
    resources '', controller:  :generic
  end

  scope '/:domain' do
    resources '', controller:  :domain_lists
  end

  resources '', controller:  :domains

end
