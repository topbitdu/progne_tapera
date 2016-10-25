module ProgneTapera::EnumConfig

  extend  ActiveSupport::Concern
  include ProgneTapera::EnumList

  included do |includer|
  end

  module ClassMethods

    def enum(name = nil)
      name = enum_name(name).to_s
      enumerations = Rails.configuration.enum[name]
      raise ArgumentError.new "The enum.#{name} was not configured in the config/enum.yml file." if enumerations.blank?
      enumerations.each do |key, value|
        options = value.map { |k, v| [ k.to_sym, v ] }.to_h
        code    = options.delete :code
        options[:localized_name] = I18n.t "enum.#{name}.#{key}"
        safe_add_item ProgneTapera::EnumItem.new(code, key, options)
      end
    end

  end

end
