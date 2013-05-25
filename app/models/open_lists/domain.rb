module OpenLists
  class Domain
    # attr_accessible :title, :body

    def self.all
      DynamicModel::ManagedDomains.domain_prefixes
    end
  end
end
