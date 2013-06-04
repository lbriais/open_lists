module OpenLists
  class Domain < ActiveRecord::Base
    attr_accessible :description, :name

    after_commit :rescan_domain

    def rescan_domain
      DynamicModel::introspect name
    end

    def empty?
      scoped_table_names.blank?
    end

    def scoped_table_names
      domain_module  = DynamicModel::ManagedDomains.domain_module name
      if domain_module
        return domain_module.scoped_table_names
      end
      nil
    end

    def model_classes
      domain_module  = DynamicModel::ManagedDomains.domain_module name
      if domain_module
        return domain_module.model_classes
      end
      nil
    end

  end
end
