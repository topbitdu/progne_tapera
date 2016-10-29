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



## Contributing

1. Fork it ( https://github.com/topbitdu/progne_tapera/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
