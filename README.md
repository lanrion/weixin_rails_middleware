# WeixinRailsMiddleware

This project rocks and uses MIT-LICENSE.

https://rubygems.org/gems/weixin_rails_middleware

Example:　https://github.com/lanrion/weixin_rails_middleware_example

## Functions

  * 自动验证微信请求。

  * 无需拼接XML格式，只需要使用 `WeixinMessageHelper` 辅助方法，即可快速回复。
    使用方法: ` render xml: reply_text_message("Your Message: #{current_message.Content}") `

  * 支持自定义token，适合一个用户使用。

  * 支持多用户token: 适合多用户注册网站，每个用户有不同的token，通过 `weixin_rails_middleware.rb` 配置好存储token的Model与字段名，即可。

  * 文本回复: `reply_text_message(content)`。

  * 音乐回复: `reply_music_message(music)`, `generate_music(title, desc, music_url, hq_music_url)`。

  * 图文回复: `reply_news_message(articles)`, `generate_article(title, desc, pic_url, link_url)`。

  * 视频回复: `replay_video_message(video)`。

  * 语音回复: `reply_voice_message(voice)`。

  * 图片回复: `reply_imgage_message(image)`。

  * 地理位置回复: 自定义需求。

## Install

  In your `Gemfile`: `gem 'weixin_rails_middleware'`

  And `bundle intall`

## Init weixin_rails_middleware

  `rails generate weixin_rails_middleware:install`

  1, It will create `config/initializers/weixin_rails_middleware.rb`

  ```
    ## NOTE:
    ## If you config all them, it will use `token_string` default
    ##
    # Th first configure is fit for your weixin public_account is saved in database.
    # "token_model" and "token_column" must in the same table.
    # "token_model" The class name that to save your public_account
    # "token_column" You can config a column name Optional, but you must have a column `weixin_token` default.
    # config.token_model  = ""
    # config.token_column = "weixin_token"

    # Or the other configure is fit for only one weixin public_account
    # If you config `token_string`, so it will directly use it
    # config.token_string = "token string"

    # Router
    # Default is "/", and recommend you use default directly.
    # config.engine_path = "/"

  ```

  2, Auto create `app/decorators/controllers/weixin_rails_middleware/weixin_controller_decorator.rb`

  Note: You need to overwrite the `reply` method. And there are two instance you can use: `@weixin_message`, `@weixin_public_account(return token_model instance if you setup "token_model", otherwise return nil)`

  3, Route

  Add a line: `WeixinRailsMiddleware::Engine, at: WeixinRailsMiddleware.config.engine_path` in `routes.rb`

## Helpers

### Generate message helpers

  Please see details in [reply_weixin_message_helper.rb](https://github.com/lanrion/weixin_rails_middleware/blob/master/lib/weixin_rails_middleware/helpers/reply_weixin_message_helper.rb)

### Weixin server url view helper
  It is `weixin_server_url(public_account=nil)`.
  If you using `token_string` default, pass with nothing, so it is `weixin_server_url`.

### Form helper

  Provide `weixin_token_field`

  Usage: `f.weixin_token_field: weixin_token`

### Auto generate weixin_token method

  If you don't want to use form helper `weixin_token_field`, so we provide: `WeiXinUniqueToken.generate(options={})`.

  Usage:

    `options` have `size` and `generator` we use `SecureRandom` to generate weixin_token, so it includes `hex, base64, random_bytes, urlsafe_base64, random_number, uuid`, default is `:hex`

    e.g. `WeiXinUniqueToken.generate(generator: "uuid")`

    Recommend: just use `WeiXinUniqueToken.generate`.

## XML parser

  We use `roxml` to generate XML and use `multi_xml` to parse `XML`, but we let them all use `nokogiri` plugin default.

## How to Test

  Install [ngrok](https://ngrok.com) and run with `ngrok 4000`, `4000` is your port that Rails Server needed

  Then, it will auto generate like this:

  ```
  Tunnel Status                 online
  Version                       1.6/1.5
  Forwarding                    http://e0ede89.ngrok.com -> 127.0.0.1:4000
  Forwarding                    https://e0ede89.ngrok.com -> 127.0.0.1:4000
  Web Interface                 127.0.0.1:4040
  # Conn                        67
  Avg Conn Time                 839.50ms

  ```

  Yes, She is `http://e0ede89.ngrok.com`.

## Contributing

  1. Fork it
  2. Create your feature branch (`git checkout -b my-new-feature`).
  3. Commit your changes (`git commit -am 'Add some feature'`).
  4. Push to the branch (`git push origin my-new-feature`).
  5. Create new Pull Request.
  6. Test with [weixin_rails_middleware_example](https://github.com/lanrion/weixin_rails_middleware_example), and push your changes.

## Bugs and Feedback
  If you discover any bugs, please describe it in the issues tracker, including Rails and InheritedResources versions.

  Or contact me <huatiaodeng@gmail.com>, <huaitao-deng@foxmail.com>, or in [Ruby China](http://ruby-china.org/) [ruby_sky](http://ruby-china.org/ruby_sky)
