require_dependency "open_lists/application_controller"

module OpenLists
  class DomainListsController < ApplicationController

    before_filter :determine_domain

    # GET /domain_lists
    # GET /domain_lists.json
    def index
      @domain_lists = DomainList.all(@domain)
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @domain_lists }
      end
    end
  
    # GET /domain_lists/1
    # GET /domain_lists/1.json
    def show
      @domain_list = DomainList.find(params[:id])
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @domain_list }
      end
    end
  
    # GET /domain_lists/new
    # GET /domain_lists/new.json
    def new
      @domain_list = DomainList.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @domain_list }
      end
    end
  
    # GET /domain_lists/1/edit
    def edit
      @domain_list = DomainList.find(params[:id])
    end
  
    # POST /domain_lists
    # POST /domain_lists.json
    def create
      @domain_list = DomainList.new(params[:domain_list])
  
      respond_to do |format|
        if @domain_list.save
          format.html { redirect_to @domain_list, notice: 'Domain list was successfully created.' }
          format.json { render json: @domain_list, status: :created, location: @domain_list }
        else
          format.html { render action: "new" }
          format.json { render json: @domain_list.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PUT /domain_lists/1
    # PUT /domain_lists/1.json
    def update
      @domain_list = DomainList.find(params[:id])
  
      respond_to do |format|
        if @domain_list.update_attributes(params[:domain_list])
          format.html { redirect_to @domain_list, notice: 'Domain list was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @domain_list.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /domain_lists/1
    # DELETE /domain_lists/1.json
    def destroy
      @domain_list = DomainList.find(params[:id])
      @domain_list.destroy
  
      respond_to do |format|
        format.html { redirect_to domain_lists_url }
        format.json { head :no_content }
      end
    end

    private

    def determine_domain
      @domain = DynamicModel::ManagedDomains.domain_module params[:domain]
    end

  end
end
