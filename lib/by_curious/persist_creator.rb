module ByCurious
  module PersistCreator
    def self.included(base)
      base.extend(ClassMethods)
    end
  end

  module ClassMethods
    def persist_creator(association, assoc_options = {})
      foreign_key = assoc_options[:foreign_key] || "#{association}_id"
      belongs_to association,
        :class_name => assoc_options[:class_name] || association.classify,
        :foreign_key => foreign_key

      validates_presence_of foreign_key
    end
  end
end

