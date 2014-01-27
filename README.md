# WeixinRailsMiddleware

This project rocks and uses MIT-LICENSE.

https://rubygems.org/gems/weixin_rails_middleware

Example:　https://github.com/lanrion/weixin_rails_middleware_example

## Function

  * 自动验证微信请求。

  * 无需拼接XML格式，只需要使用 `WeixinMessageHelper` 辅助方法，即可快速回复。
    使用方法: ` render xml: reply_text_message(current_message.ToUserName, current_message.FromUserName, "Your Message: #{current_message.Content}") `

  * 支持自定义token，适合一个用户使用。

  * 支持多用户token: 适合多用户注册网站，每个用户有不同的token，通过 `weixin_rails_middleware.rb` 配置好存储token的Model与字段名，即可。

  * 文本回复: `reply_text_message(from, to, content)`。

  * 音乐回复: `reply_music_message(from, to, music)`。

  * 图文回复: `reply_news_message(from, to, articles)`。

  * 视频回复: `replay_video_message(video)`。

  * 语音回复: `reply_voice_message(voice)`。

  * 图片回复: `reply_imgage_message(image)`。

  * 地理位置回复: 自定义需求。

## Install

  In your `Gemfile`: `gem 'weixin_rails_middleware'`

  And `bundle intall`

## Init weixin_rails_middleware

  `rails generate weixin_rails_middleware:install`

  It will create `config/initializers/weixin_rails_middleware.rb`

  Note: You need to checkout comments in file

  And

  Create `app/decorators/controllers/weixin_rails_middleware/weixin_controller_decorator.rb`

  Note: You need to overwrite the `reply` method.

  Other

  Add a line: `WeixinRailsMiddleware::Engine, at: WeixinRailsMiddleware.config.engine_path` in `routes.rb`

## Helpers

  Please see detail in `weixin_message_helper.rb`

## Weixin Server Api URl
  Default: `http://www.example.com/weixin/"#{weixin_token}"`

  And if you config `engine_path` in `config/initializers/weixin_rails_middleware.rb`
  It should be generate: `http://www.example.com/your_config_engine_path/weixin/"#{weixin_token}"`

## How to test
  Install `ngrok` and run with `ngrok 4000`, `4000` is your port that Rails Server needed

  Then, it will generate like this:

  ```
  Tunnel Status                 online
  Version                       1.6/1.5
  Forwarding                    http://e0ede89.ngrok.com -> 127.0.0.1:4000
  Forwarding                    https://e0ede89.ngrok.com -> 127.0.0.1:4000
  Web Interface                 127.0.0.1:4040
  # Conn                        67
  Avg Conn Time                 839.50ms

  ```

  Yes, She is `http://e0ede89.ngrok.com`

  神器！！

## TODO

  * 添加微信自定义菜单

