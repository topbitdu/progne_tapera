##
# Enum Code 是在模型层配置知识层枚举的关注点，提供 .code 宏方法。

module ProgneTapera::EnumCode

  extend ActiveSupport::Concern

  included do |includer|
  end

  module ClassMethods

    ##
    # 为关注的类提供以下逻辑：
    # 1. 验证 ``field``_code 字段的值，是否在枚举类型的定义中。
    # 2. 定义 ``field`` 方法，用于获取枚举型的值。
    # 3. 定义 ``field``= 方法，用于为枚举型字段赋值。
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
