require_dependency "open_lists/application_controller"

module OpenLists
  class DomainsController < ApplicationController

    before_filter :determine_domain

    # GET /domains
    # GET /domains.json
    def index
      @domains = Domain.order(sort_column + " " + sort_direction)

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @domains }
        format.js # index.js.coffee
      end

    end

    # GET /domains/new
    # GET /domains/new.json
    def new
      @domain = Domain.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @domain }
      end
    end
  
    # GET /domains/1/edit
    def edit
      @domain = Domain.find(params[:id])
    end
  
    # POST /domains
    # POST /domains.json
    def create
      @domain = Domain.new(params[:domain])
  
      respond_to do |format|
        if @domain.save
          format.html { redirect_to view_context.domains_path, notice: 'Domain was successfully created.' }
          format.json { render json: @domain, status: :created, location: @domain }
        else
          format.html { render action: "new" }
          format.json { render json: @domain.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PUT /domains/1
    # PUT /domains/1.json
    def update
      @domain = Domain.find(params[:id])
  
      respond_to do |format|
        if @domain.update_attributes(params[:domain])
          format.html { redirect_to @domain, notice: 'Domain was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @domain.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /domains/1
    # DELETE /domains/1.json
    def destroy
      @domain = Domain.find(params[:id])
      @domain.destroy
  
      respond_to do |format|
        format.html { redirect_to domains_url }
        format.json { head :no_content }
      end
    end

    private

    def determine_domain
      @model = OpenLists::Domain
    end

  end
end
