module OpenLists
  class DomainList
    # attr_accessible :title, :body
    def self.all(domain_module)
      domain_module.scoped_table_names
    end

  end
end
