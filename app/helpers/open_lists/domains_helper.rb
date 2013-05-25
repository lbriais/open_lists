module OpenLists
  module DomainsHelper

    def domain_path(domain = @domain)
      path = (domain.class == String) ? domain : domain.prefix
      "/#{module_base_url}/#{path}"
    end
  end
end
