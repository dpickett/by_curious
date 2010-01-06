module ByCurious
  module ControllerExtensions
    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
    end
  end
    
  module ClassMethods
    def authorize_resources
      enable_resource_filters
      include ByCurious::Helper
    end

    protected
      def enable_resource_filters
        before_filter :verify_create_authorization, :only => create_actions
        before_filter :verify_edit_authorization, :only => edit_actions
        before_filter :verify_destroy_authorization, :only => destroy_actions
      end

      def create_actions
        [:new, :create]
      end

      def edit_actions
        [:edit, :update]
      end

      def destroy_actions
        [:destroy]
      end
  end

  module InstanceMethods
    protected
      def require_user
        deny_access unless current_user
      end

      def deny_access
        if current_user
          deny_unauthorized_user
        else
          deny_visitor
        end
      end

      def deny_unauthorized_user
        redirect_to user_denied_redirection_path
        flash[:error] = user_denied_message
      end

      def user_denied_redirection_path
        root_path
      end

      def user_denied_message
        'You are not authorized to access this resource'
      end

      def deny_visitor
        redirect_to visitor_denied_redirection_path
        flash[:error] = visitor_denied_message
      end

      def visitor_denied_redirection_path
        root_path
      end

      def visitor_denied_message
        'You must sign in'
      end

      def verify_create_authorization
        deny_access unless creatable?
      end

      def verify_edit_authorization
        deny_access unless editable?
      end

      def verify_destroy_authorization
        deny_access unless destroyable?
      end

      def creatable?
        resource_class.creatable_by?(current_user)
      end

      def editable?
        resource_exists? && resource.editable_by?(current_user)
      end

      def destroyable?
        resource_exists? && resource.destroyable_by?(current_user) 
      end

      def resource_exists?
        !resource.nil?
      end
  end
end
