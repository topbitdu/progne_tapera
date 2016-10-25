require 'rails'

class ProgneTapera::EnumItem

  attr_reader :code, :name

  # code = HA (value)
  # name = han
  # options = { localized_name: '汉' }
  # -> constant: HAN
  def initialize(code, name, options = {})

    raise ArgumentError.new 'The code argument is required.' if code.blank?
    raise ArgumentError.new 'The name argument is required.' if name.blank?

    @code    = code
    @name    = name
    @options = options

    @options.each do |key, value|
      class_eval do
        define_method(key.to_sym) do
          value
        end
      end
    end

  end

  def ==(that)
    self.code==that.code
  end

  def <=>(that)
    self.code<=>that.code
  end

  def constant_name
    name.to_s.upcase
  end

end
