module ByCurious
  module ModelExtensions
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def by_curious
        extend ByCuriousClassMethods
        send(:include, ByCuriousInstanceMethods)
      end
    end

    module ByCuriousClassMethods
      def creatable_by?(user)
        true
      end
    end
    
    module ByCuriousInstanceMethods
      def creatable_by?(user)
        self.class.creatable_by?(user)
      end

      def editable_by?(user)
        true
      end

      def destroyable_by?(user)
        true
      end
    end

  end
end
