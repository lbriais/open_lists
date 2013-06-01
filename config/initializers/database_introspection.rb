# Introspects database registered domains.
DynamicModel::introspect_database OpenLists::Domain.all.map {|domain| domain.name}