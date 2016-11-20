module ProgneTapera::EnumConfig

  extend  ActiveSupport::Concern
  include ProgneTapera::EnumList

  included do |includer|
  end

  module ClassMethods

    def enum(name = nil, localized_name = name)

      name         = enum_name(name).to_s
      enumerations = Rails.configuration.enum[name]
      raise ArgumentError.new("The enum.#{name} was not configured in the config/enum.yml file.") if enumerations.blank?

      enumerations.each do |key, value|
        options = value.map { |k, v| [ k.to_sym, v ] }.to_h
        code    = options.delete :code
        options[:localized_name] = I18n.t "enum.#{localized_name||name}.#{key}"
        safe_add_item ProgneTapera::EnumItem.new(code, key, options)
      end

    end

    def overload_enum_i18n(localized_name = nil)

      each do |enum_item|
        enum_item.options[:localized_name] = I18n.t "enum.#{localized_name}.#{enum_item.name}"
      end

    end

  end

end
