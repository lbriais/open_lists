module OpenLists
  module DomainsHelper

    def domain_path(domain = @domain)
      path = (domain.class == String) ? domain : domain.prefix
      "/#{module_base_url}/#{path}"
    end

    def new_domain_path
      "/#{module_base_url}/new"
    end

    def domains_path(*args)
      "/#{module_base_url}"
    end

  end
end
