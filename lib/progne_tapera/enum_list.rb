require 'rails'

##
# Enum List 是枚举列表。
module ProgneTapera::EnumList

  extend ActiveSupport::Concern

  included do |includer|
  end

  module ClassMethods

    include Enumerable

    # Define the Enum type
    def enum_name(name = nil)
      return @enum_name if @enum_name.present?
      @enum_name = (name||self.name.demodulize.underscore).to_sym
    end

    # Define the Enum Items
    def item_defined?(item)
      const_defined? item.constant_name
    end

    def add_item(item)
      raise ArgumentError.new "The #{item.inspect} item should be an instance of ProgneTapera::EnumItem." unless item.is_a?    ProgneTapera::EnumItem
      raise ArgumentError.new "The #{item.constant_name} enum item was defined already."                  if     item_defined? item

      item_methods_module = "#{self.name}::ItemMethods".safe_constantize
      item.class.include item_methods_module if item_methods_module.present?

      const_set item.constant_name, item
    end

    def safe_add_item(item)
      const_set item.constant_name, item if item.is_a?(ProgneTapera::EnumItem)&&!item_defined?(item)
    end

    # Infrastructure for the Enumerable
    def enum_constants
      constants.select { |constant|
        value = const_get constant
        value.is_a? ProgneTapera::EnumItem
      }
    end

    def all
      enum_constants.map { |constant| const_get constant }
    end

    def selected
      block_given? ? yield(all) : all
    end

    # Enumerable
    def each(&block)
      all.each &block
    end

    # Lookup
    def lookup(code)
      select { |item| item.code==code }.first
    end

    # Form Option
    def form_options(&block)
      items = block_given? ? selected(&block) : selected
      items.map { |item| [ item.localized_name, item.code ] }.to_h
    end

    # ActiveRecord::Type::Value
    def deserialize(value)
      select { |item| item.code==value }
    end

    def serialize(value)
      value.respond_to?(:code) ? value.code : value
    end

  end

end
