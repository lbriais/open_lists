require_dependency "open_lists/application_controller"

module OpenLists
  class GenericController < ApplicationController
    before_filter :determine_model

    # GET /shared_lists
    # GET /shared_lists.json
    def index
      @items = @model.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:per])
      if @items.empty? && params[:page]
        params[:page] = nil
        @items = @model.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:per])
      end
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @items }
        format.js # index.js.coffee
      end
    end




    private

    def determine_model
      DynamicModel.introspect_database
      @domain ||= DynamicModel::ManagedDomains.domain_module(params[:domain])
      @model ||= @domain.model_class(params[:list_name])
    end

    def sort_column
      @model.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
      %w[desc asc].include?(params[:direction]) ? params[:direction] : "desc"
    end

  end
end
