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
      sort_direction == 'desc' ? 'asc' : 'desc'
    end
    def display_current_direction() DIRECTIONS[current_direction.to_sym] end
    def display_other_direction() DIRECTIONS[other_direction.to_sym] end



    def sortable_link(column, title: nil, css_class: "")
      column = column.to_s
      title = column.titleize if title.nil?
      css_class += column == sort_column ? " current_sort #{current_direction}" : ""
      direction = column == sort_column ? other_direction : current_direction
      link_to title, params.merge(sort: column, direction: direction), class: css_class, remote: true, method: :get
    end

    def sortable_link_as_button(column, title: nil, css_class: 'btn btn-mini')
      sortable_link column, title: title, css_class: css_class
    end


    def per_link(value, css_class: "")
      value = Kaminari::Configuration.default_per_page if value.nil?
      link_to value, params.merge(per: value), class: css_class, remote: true, method: :get
    end

    def per_button(value)
      per_link value, css_class: 'btn btn-mini'
    end

    def items_per_page_button_tag(value)
      render partial: 'items_per_page_button', locals: {value: value}
    end

    def column_list_header_button_tag(column)
      render partial: 'column_list_header_button', locals: {column: column, title: @model.human_attribute_name(column)}
    end


  end
end
