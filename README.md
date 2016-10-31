# Progne Tapera

[![License](https://img.shields.io/badge/license-MIT-green.svg)](http://opensource.org/licenses/MIT)
[![Gem Version](https://badge.fury.io/rb/progne_tapera.svg)](https://badge.fury.io/rb/progne_tapera)
[![Dependency Status](https://gemnasium.com/badges/github.com/topbitdu/progne_tapera.svg)](https://gemnasium.com/github.com/topbitdu/progne_tapera)

Progne Tapera is a Rails-based configurable enumeration implementation. Progne Tapera is the Brown-chested Martin in Latin.
Progne Tapera 是基于 Rails 的可配置的枚举实现。Progne Tapera 是棕胸崖燕的拉丁学名。



## Recent Update

Check out the [Road Map](ROADMAP.md) to find out what's the next.
Check out the [Change Log](CHANGELOG.md) to find out what's new.



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'progne_tapera'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install progne_tapera



## Usage

config/initializers/enum.rb
```ruby
Unidom::Common::YamlHelper.load_enum config: Rails.configuration, root: Rails.root
```

config/enum.yml
```yaml
enum:

  gender:
    male:
      code: '1'
    female:
      code: '2'
    not_specified:
      code: '9'

  china_ethnicity:
    han:
      code: HA
      numeric_code: '01'
    mongel:
      code: 'MG'
      numeric_code: '02'
```

config/locales/enum.zh-CN.yml
```yaml
'zh-CN':
  enum:

    gender:
      male:          男
      female:        女
      not_specified: 未指定

    china_ethnicity:
      han:    汉
      mongel: 蒙古
```

app/types/gender.rb
```ruby
class Gender < ActiveRecord::Type::Value

  include ProgneTapera::EnumConfig

  enum

end
```

app/types/ethnicity.rb
```ruby
class Ethnicity < ActiveRecord::Type::Value

  include ProgneTapera::EnumConfig

  enum :china_ethnicity

end
```



## Include the Concerns

```ruby
include ProgneTapera::EnumList
include ProgneTapera::EnumConfig
```

### Enum List concern

The Enum List concern do the following tasks for the includer automatically:  
1. Include the Enumerable module  
2. Define the .enum_name method as: ``enum_name(name = nil)``  
3. Define the .item_defined? method as: ``item_defined?(item)``  
4. Define the .add_item method as: ``add_item(item)``  
5. Define the .safe_add_item method as: ``safe_add_item(item)``  
6. Define the .enum_constants method as: ``enum_constants``  
7. Define the .all method as: ``all``  
8. Define the .selected method as: ``selected(&block)``  
9. Define the .each method as: ``each(&block)``  
10. Define the .form_options method as: ``form_options(&block)``  
11. Define the .deserialize method as: ``deserialize(value)``  
12. Define the .serialize method as: ``serialize(value)``

### Enum Config concern

The Enum Config concern do the following tasks for the includer automatically:  
1. Include the Enum List concern  
2. Define the .enum method as: ``enum(name = nil)``



## Contributing

1. Fork it ( https://github.com/topbitdu/progne_tapera/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
