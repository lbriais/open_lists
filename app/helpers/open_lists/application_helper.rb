module OpenLists
  module ApplicationHelper

    DIRECTIONS = {
        desc: I18n.t('.ascending', :default => "descending"),
        asc:  I18n.t('.ascending', :default => "ascending")
    }

    def current_direction
      sort_direction
    end
    def other_direction
      sort_direction == 'desc' ? 'asc' : 'desc'
    end
    def display_current_direction() DIRECTIONS[current_direction.to_sym] end
    def display_other_direction() DIRECTIONS[other_direction.to_sym] end


    ## 
    # @return a (remote) link to invert the current direction of the sort set through the session context in the list display
    # @param [String] column: the name of the column to sort the list by
    # @param [String] title: An optional title for the link (if not provided, will be guessed from the column name)
    # @param [String] title: An optional css class for the generated link
    def sortable_link(column, title: nil, css_class: "")
      column = column.to_s
      title = column.titleize if title.nil?
      css_class += column == sort_column ? " current_sort #{current_direction}" : ""
      direction = column == sort_column ? other_direction : current_direction
      link_to title, params.merge(sort: column, direction: direction), class: css_class, remote: true, method: :get
    end

    ## 
    # @return a (remote) bootstrap button to invert the current direction of the sort set through the session context in the list display
    # @param [String] column: the name of the column to sort the list by
    # @param [String] title: An optional title for the link (if not provided, will be guessed from the column name)
    # @param [String] title: An optional css class for the generated link
    def sortable_link_as_button(column, title: nil, css_class: 'btn btn-mini')
      sortable_link column, title: title, css_class: css_class
    end

    ##
    # @return a (remote) link to set the param[:per] value for the number of items displayed in a list
    # @param [Integer] value: number of item to display in a list
    # @param [String] css_class: an optional css class for the generated link
    def per_link(value = params[:per], css_class = "")
      value = Kaminari.config.default_per_page if value.nil? #
      link_to value.to_s, params.merge(per: value), class: css_class, remote: true, method: :get
    end

    ##
    # @return a (remote) bootstrap button to set the param[:per] value for the number of items displayed in a list
    # @param [Integer] value: number of item to display in a list
    # @param [String] css_class: an optional css class for the generated link
    def per_link_as_button(value = nil, css_class = 'btn btn-mini')
      per_link value, css_class
    end

    ##
    # @return piece of html corresponding to the selector for the number of items to display in a list
    # @param [Integer] value: number of item to display in a list
    def items_per_page_button_tag(value)
      render partial: 'items_per_page_button', locals: {value: value}
    end

    ##
    # @return piece of html corresponding to the header of the column in list display
    # @param [String] column
    # @param [Class] model
    def column_list_header_button_tag(column, model = @model)
      render partial: 'column_list_header_button', locals: {column: column, title: model.human_attribute_name(column)}
    end


    ##
    # @return a display name for the item. many options there.
    # It will take the best option:
    # * if the item itself knows how to be displayed (respond_to? :display_name_for_item), it will be the preferred choice
    # * if there is a non empty title column, it will use it.
    # * if there is a non empty name column, it will use it.
    # * if none of the above, it will display the name of class item is an instance of follow by the id number
    # * if there is no id (bad!!), it will display "No name"
    # @param [ActiveRecord::Base] item
    def display_name_for_item(item)
      return "" if item.nil?
      name = I18n.t('.no_name', :default => "No name")
      if item.attribute_names.include? 'id'
        name = "#{item.class.name.titleize} ##{item.attributes['id']}"
        name = "#{item.class.display_name} ##{item.attributes['id']}" if item.class.respond_to? :display_name
      end
      name = item.attributes['name'] unless item.attributes['name'].blank?
      name = item.attributes['title'] unless item.attributes['title'].blank?
      name = item.class.display_name_for_item(item) if item.class.respond_to? :display_name_for_item
      name
    end

    def collections_linked_to(model = @model)
      model.reflections.keys.map do |column|
        column if model.reflections[column].collection?
      end .compact
    end


    ##
    # @return an array of editable attributes for this model
    # REVIEW: shouldn't primary key and timestamps be removed at this level ?
    # @param [Class] model
    def fields_to_edit_for_model(model = @model)
      model.attribute_names
    end


    ##
    # @return an of the fields to be displayed for this model
    # @param [Class] model
    def fields_to_display_for_model(model = @model)
      fields = model.attr_accessible[:default].to_a - [""]
      fields = model.attribute_names if fields.empty?
      fields
    end

    ##
    # @return the base url of the engine
    def module_base_url
      Engine.routes.default_scope[:module]
    end

  end
end
