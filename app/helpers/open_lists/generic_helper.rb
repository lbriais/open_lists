module OpenLists
  module GenericHelper
    def new_item_path
      return "/#{module_base_url}/#{params[:domain]}/#{params[:list_name]}/new" if params[:domain] and params[:list_name]
      "/#{module_base_url}/#{@domain.to_param}"
    end

    def item_path(item = @item)
      return "/#{module_base_url}/#{params[:domain]}/#{params[:list_name]}/#{params[:id]}" if params[:domain] and params[:list_name] and params[:id]
      return "/#{module_base_url}/#{item.class.to_param}/#{item.to_param}"  unless item.nil?
      nil
    end


    def edit_item_path(item = @item)
      "#{item_path item}/edit"
    end

    def fields_to_display_for_model
      @model.attribute_names
    end

    def field_as_display_element(item, attribute)
      attribute_type = item.class.columns_hash[attribute].type
      case attribute_type
        when :integer
          # Special case: is it a link to another table
          if item.class.reflections.keys.include? attribute.gsub(DynamicModel::RelationsAnalyser::KEY_IDENTIFIER, '')
            child = item.send attribute.gsub(DynamicModel::RelationsAnalyser::KEY_IDENTIFIER, '').to_sym
            return link_to(name_for_link(child), item_path(child))
          end
          # Else just show the number
          item.attributes[attribute]
        when :boolean
          check_box_tag attribute, "", item.attributes[attribute], disabled: true
        else
          h item.attributes[attribute]
      end
    end

    def module_base_url
      Engine.routes.default_scope[:module]
    end


  end
end
