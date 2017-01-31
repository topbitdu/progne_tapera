##
# Enum Config 是知识层枚举类型的配置关注点。提供 .enum 和 .overload_enum_i18n 方法。

module ProgneTapera::EnumConfig

  extend  ActiveSupport::Concern
  include ProgneTapera::EnumList

  included do |includer|
  end

  module ClassMethods

    def enum(name = nil, localized_name = name)

      if block_given?

        yield.each do |key, value|
          options = value.map { |k, v| [ k.to_sym, v ] }.to_h
          #options[:optional] = true if options[:optional].nil?
          code    = options.delete :code
          safe_add_item ProgneTapera::EnumItem.new(code, key.to_s, options)
        end

      else

        name         = enum_name(name).to_s
        enumerations = Rails.configuration.enum[name]
        raise ArgumentError.new("The enum.#{name} was not configured in the config/enum.yml file.") if enumerations.blank?

        enumerations.each do |key, value|
          options = value.map { |k, v| [ k.to_sym, v ] }.to_h
          #options[:optional] = false
          code    = options.delete :code
          options[:localized_name] = I18n.t "enum.#{localized_name||name}.#{key}"
          item = ProgneTapera::EnumItem.new code, key, options
          class << item
            item_method_module = "#{self.name}::ItemMethods".safe_constantize
            include item_method_module if item_method_module.present?
          end
          safe_add_item item
        end

      end

    end

    def overload_enum_i18n(localized_name = nil)

      each do |enum_item|
        enum_item.options[:localized_name] = I18n.t "enum.#{localized_name}.#{enum_item.name}"
      end

    end

  end

end
