module OpenLists
  module GenericHelper
    def new_item_path
      return "/#{module_base_url}/#{params[:domain]}/#{params[:list_name]}/new" if params[:domain] and params[:list_name]
      "/#{module_base_url}/#{@domain.to_param}"
    end

    def item_path(item = @item)
      return "/#{module_base_url}/#{params[:domain]}/#{params[:list_name]}/#{params[:id]}" if params[:domain] and params[:list_name] and params[:id]
      return "#{model_path(item.class)}/#{item.to_param}" unless item.nil?
      nil
    end

    def model_path(model = @model)
      "/#{module_base_url}/#{model.to_param}"
    end

    def edit_item_path(item = @item)
      "#{item_path item}/edit"
    end

    def form_options(item = @item)
      url = item_path(item)
      {url: url, controller: 'OpenLists::Generic'}
    end

    def name_for_link(item)
      return "" if item.nil?
      name = 'No name'
      name = "#{item.class.display_name} #{item.attributes['id']}" if item.attribute_names.include? 'id'
      name = item.attributes['name'] if item.attribute_names.include? 'name'
      name = item.attributes['title'] if item.attribute_names.include? 'title'
      name = item.class.name_for_link(item) if item.class.respond_to? :name_for_link
      name
    end

    def fields_to_edit_for_model(model = @model)
      model.attribute_names
    end

    def fields_to_display_for_model(model = @model)
      fields = model.attr_accessible[:default].to_a - [""]
      fields = model.attribute_names if fields.empty?
      fields
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

    def field_as_edit_element(form, model, attribute)
      attribute_type =  model.columns_hash[attribute].type
      case attribute_type
        when :integer
          # Is it the primary key ?
          return form.text_field(attribute.to_sym, disabled: true) if attribute == model.primary_key
          # Special case: is it a link to another table
          # if it's any it should end with DynamicModel::RelationsAnalyser::KEY_IDENTIFIER
          reflection_key = attribute.gsub(DynamicModel::RelationsAnalyser::KEY_IDENTIFIER, '')
          if model.reflections.keys.include? reflection_key
            return form.select(attribute, model.reflections[reflection_key].class_name.constantize.all.map{|s| [ name_for_link(s), s[s.class.primary_key] ]}, {include_blank: 'None'})
          end
          # Else just show the number
          form.number_field attribute.to_sym
        when :boolean
          form.check_box attribute.to_sym
        when :datetime
          if ['created_at', 'updated_at'].include? attribute
            form.text_field attribute.to_sym, disabled: true
          else
            form.text_field attribute.to_sym
          end
        else
          form.text_field attribute.to_sym
      end
    end
    def module_base_url
      Engine.routes.default_scope[:module]
    end


  end
end
