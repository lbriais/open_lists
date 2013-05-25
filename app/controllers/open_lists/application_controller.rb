module OpenLists
  class ApplicationController < ActionController::Base

    protected

    def determine_model
      determine_domain
      unless @domain.nil?
        @model ||= @domain.model_class(params[:list_name])
        redirect_to controller: :domain_lists, action: :index unless @model
      end
    end

    def determine_domain
      @domain ||= DynamicModel::ManagedDomains.domain_module params[:domain]
      redirect_to controller: :domains, action: :index unless @domain
    end


  end
end
