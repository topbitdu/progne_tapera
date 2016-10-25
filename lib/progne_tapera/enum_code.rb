module ProgneTapera::EnumCode

  extend ActiveSupport::Concern

  included do |includer|
  end

  module ClassMethods

    def code(field, enum)
      code_field_name = :"#{field}_code"
      validates code_field_name, inclusion: enum.all.map { |item| item.code }
      instance_eval do
        define_method field do
          enum.select { |item| item.code==send(code_field_name.to_sym) }.first
        end
        define_method "#{field}=" do |value|
          send "#{code_field_name}=".to_sym, value.code
        end
      end
    end

  end

end
