module OpenLists
  class Domain < ActiveRecord::Base
    include DynamicModel::DomainExtension
    attr_accessible :description, :name

    after_commit :rescan_domain

    def rescan_domain
      DynamicModel::introspect name
    end

  end
end