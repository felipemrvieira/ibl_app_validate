class BackofficeController < ActionController::Base
    layout "backoffice"    
    include Pagy::Backend

    #Pundit
    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def pundit_user
        current_unit
    end

    # def policy_scope(scope)
    #     super([:backoffice, scope])
    # end

    # def authorize(record, query = nil)
    #     super([:backoffice, record], query)
    # end

    protected

        def user_not_authorized
            flash[:alert] = "Você não tem autorização para realizar esta ação."
            redirect_to(request.referrer || backoffice_dashboard_path)
        end
        
end
