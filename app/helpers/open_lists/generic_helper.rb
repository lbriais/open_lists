# -*- coding: utf-8 -*-
module OpenLists
  module GenericHelper

    # @return the path for a new item
    def new_item_path
      return "/#{module_base_url}/#{params[:domain]}/#{params[:list_name]}/new" if params[:domain] and params[:list_name]
      "/#{module_base_url}/#{@domain.to_param}"
    end

    # @return the path to the list item passed (default is current)
    # @param [DynamicModel::ActiveRecordExtension] item
    def item_path(item = @item)
      return "#{model_path(item.class)}/#{item.to_param}" unless item.nil?
      "/#{module_base_url}/#{params[:domain]}/#{params[:list_name]}/#{params[:id]}" if params[:domain] and params[:list_name] and params[:id]
    end

    # @return the path to the list index passed (default is current)
    # @param [Class] model
    def model_path(model = @model)
      "/#{module_base_url}/#{model.to_param}"
    end

    # @return the edit path to the list item passed (default is current)
    # @param [DynamicModel::ActiveRecordExtension] item
    def edit_item_path(item = @item)
      "#{item_path item}/edit"
    end


    # @return provides an option hash for the form tag as the controller is very specific
    # @param [DynamicModel::ActiveRecordExtension] item
    def form_options(item = @item)
      {url: item_path(item), controller: 'OpenLists::Generic'}
    end

    ## 
    # @return the html to display the attribute of the item
    # @param [ActiveRecord::Base] item
    # @param [String] attribute
    def field_as_display_element(item, attribute)
      attribute_type = item.class.columns_hash[attribute].type
      case attribute_type
        when :integer
          # Special case: is it a link to another table
          if item.class.reflections.keys.include? attribute.gsub(DynamicModel::RelationsAnalyser::KEY_IDENTIFIER, '').to_sym
            child = item.send attribute.gsub(DynamicModel::RelationsAnalyser::KEY_IDENTIFIER, '').to_sym
            return link_to(display_name_for_item(child), item_path(child))
          end
          # Else just show the number
          item.attributes[attribute]
        when :boolean
          check_box_tag attribute, "", item.attributes[attribute], disabled: true
        else
          h item.attributes[attribute]
      end
    end

    ## 
    # @return the html to edit the attribute of the item
    # @param [ActionView::Helpers::FormBuilder] form
    # @param [Class] model (descendant of ActiveRecord::Base)
    # @param [String] attribute
    def field_as_edit_element(form, model, attribute)
      attribute_type =  model.columns_hash[attribute].type
      case attribute_type
        when :integer
          # Is it the primary key ?
          return form.text_field(attribute.to_sym, disabled: true) if attribute == model.primary_key
          # Special case: is it a link to another table?
          # if it is, then it should end with DynamicModel::RelationsAnalyser::KEY_IDENTIFIER
          reflection_key = attribute.gsub(DynamicModel::RelationsAnalyser::KEY_IDENTIFIER, '').to_sym
          if model.reflections.keys.include? reflection_key
            content = model.reflections[reflection_key].class_name.constantize.all.map do |s|
              [ display_name_for_item(s), s[s.class.primary_key] ]
            end
            return form.select(attribute, content, {include_blank: I18n.t('openlists.none', default: 'None')})
          end
          # Else just show the number
          form.number_field attribute.to_sym
        when :boolean
          form.check_box attribute.to_sym
        when :datetime
          if ['created_at', 'updated_at'].include? attribute
            form.text_field attribute.to_sym, disabled: true
          else
            form.text_field attribute.to_sym, class: "date-picker-field"
          end
        else
          form.text_field attribute.to_sym
      end
    end

  end
end
