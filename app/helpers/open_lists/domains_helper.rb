module OpenLists
  module DomainsHelper

    def domain_path(domain = @domain)
      domain
      domain.prefix unless domain.class == String
    end
  end
end
