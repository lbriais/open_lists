module OpenLists
  module DomainListsHelper
    def domain_list_path(domain_list = @domain_list)
      "#{domain_path}/#{domain_list}"
    end
  end
end
