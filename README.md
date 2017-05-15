# OpenConf Api

- OpenConf Konferans sistemi için hazırlanan ve sistemin veritabanına bağlantı yaparak api hizmeti sunmayı amaçlayan bir projedir.
- Kemal kullanılarak geliştirilmiştir.
- Şuan ki sürüm çok basit birkaç özelliğe sahiptir.

## Installation

```crystal
  crystal build --release src/openconf_api.cr
```

## Usage

```bash
  MYSQL_URL="mysql://root:root@localhost:3306/openconf"\
  ACCESS_TOKEN=ca1ea6a0cbc0b0c8bc374a241fd009850fdc000bfba368a03d\
  KEMAL_ENV=production openconf_api --port 3001 openconf_api
```

## Contributing

1. Fork it ( https://github.com/isubas/openconf_api/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [@isubas](https://github.com/isubas) irfan subas - creator, maintainer
