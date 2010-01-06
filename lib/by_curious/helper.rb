module ByCurious
  module Helper
    def self.included(base)
      base.helper_method :can?, :cannot?
    end

    def can?(action, obj_or_klass)
      obj = derive_object(obj_or_klass) 
      obj.send(action_by_method_pairs[action], current_user)
    end

    def cannot?(action, obj_or_klass)
      !can?(action, obj_or_klass)
    end

    protected
      def action_by_method_pairs
        {
          :destroy => :destroyable_by?,
          :create  => :creatable_by?,
          :edit    => :editable_by?,
          :update  => :editable_by?
        }
      end

    private
      def derive_object(obj_or_klass)
        obj_or_klass.is_a?(Class) ? obj_or_klass.new : obj_or_klass
      end
  end
end

