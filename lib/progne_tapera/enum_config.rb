##
# Enum Config 是知识层枚举类型的配置关注点。提供 .enum 和 .overload_enum_i18n 方法。

module ProgneTapera::EnumConfig

  extend  ActiveSupport::Concern
  include ProgneTapera::EnumList

  included do |includer|
  end

  module ClassMethods

    ##
    # 为枚举类型提供 .enum 方法。如：
    # enum :gender
    # # 或
    # enum :gender, :localized_gender
    # 第一个参数是枚举类型在配置文件中存储的枚举项的 key 。
    # 第二个参数是枚举类型在国际化配置文件中存储的枚举项文本的 key 。如果不提供第二个参数，则自动使用第一个参数进行查找。
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

          item_method_module = "#{self.name}::ItemMethods".safe_constantize
          item.class_eval do
            include item_method_module if item_method_module.present?
          end
          #class << item
          #  include item_method_module if item_method_module.present?
          #end

          safe_add_item item
        end

      end

    end

    ##
    # 为枚举类型提供 .overload_enum_i18n 方法。如：
    # overload_enum_i18n :your_gender_i18n_key
    def overload_enum_i18n(localized_name = nil)

      each do |enum_item|
        enum_item.options[:localized_name] = I18n.t "enum.#{localized_name}.#{enum_item.name}"
      end

    end

  end

end
