module OpenLists
  class ApplicationController < ActionController::Base
    helper_method :sort_column, :sort_direction

    def sort_column
      @model.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
      %w[desc asc].include?(params[:direction]) ? params[:direction] : "desc"
    end

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
