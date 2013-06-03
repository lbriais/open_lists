# -*- coding: utf-8 -*-
# Introspects database registered domains.
begin
  DynamicModel::introspect_database OpenLists::Domain.all.map {|domain| domain.name}
rescue => e
  puts "Unable to introspect database (#{e.message})..."
end
