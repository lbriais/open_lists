OpenLists::Engine.routes.draw do
  scope '/:domain/:list_name' do
    get 'define', controller: :generic, action: :define_model
    resources '', controller:  :generic
  end

  #scope '/:domain' do
  #  resources '', controller:  :domain_lists
  #end

  get '', controller:  :domains, action: :index
  get '/:domain', controller: :domains, action: :index, domain: ':domain'

end
