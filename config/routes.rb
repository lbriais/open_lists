OpenLists::Engine.routes.draw do
  scope '/:domain/:list_name' do
    resources '', controller:  :generic
  end
end
