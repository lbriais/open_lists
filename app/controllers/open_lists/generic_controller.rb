require_dependency "open_lists/application_controller"

module OpenLists
  class GenericController < ApplicationController
    before_filter :determine_model
    helper_method :sort_column, :sort_direction

    # GET /open_lists/:domain/:list_name
    # GET /open_lists/:domain/:list_name.json
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

    # GET /open_lists/:domain/:list_name/1
    # GET /open_lists/:domain/:list_name/1.json
    def show
      @item = @model.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @item }
      end
    end

    # GET /open_lists/:domain/:list_name/new
    # GET /open_lists/:domain/:list_name/new.json
    def new
      @item = @model.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @item }
      end
    end

    # GET /open_lists/:domain/:list_name/1/edit
    def edit
      @item = @model.find(params[:id])
    end

    # POST /open_lists/:domain/:list_name
    # POST /open_lists/:domain/:list_name.json
    def create
      @item = @model.new(params[actual_list_param_name])

      respond_to do |format|
        if @item.save
          format.html { redirect_to view_context.item_path(@item), notice: 'Item was successfully created.' }
          format.json { render json: @item, status: :created, location: @item }
        else
          format.html { render action: "new" }
          format.json { render json: @item.errors, status: :unprocessable_entity }
        end
      end
    end

    # PUT /open_lists/:domain/:list_name/1
    # PUT /open_lists/:domain/:list_name/1.json
    def update
      @item = @model.find(params[:id])
      respond_to do |format|
        if @item.update_attributes(params[actual_list_param_name])
          format.html { redirect_to view_context.item_path(@item), notice: 'Item was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @item.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /open_lists/:domain/:list_name/1
    # DELETE /open_lists/:domain/:list_name/1.json
    def destroy
      @item = @model.find(params[:id])
      @item.destroy

      respond_to do |format|
        format.html { redirect_to model_url }
        format.json { head :no_content }
      end
    end





    private

    def determine_model
      @domain ||= DynamicModel::ManagedDomains.domain_module(params[:domain])
      @model ||= @domain.model_class(params[:list_name])
    end

    def actual_list_param_name
      @model.name.underscore.tr '/', '_'
    end

    def sort_column
      @model.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
      %w[desc asc].include?(params[:direction]) ? params[:direction] : "desc"
    end

  end
end
