# WeixinRailsMiddleware

This project rocks and uses MIT-LICENSE.

https://rubygems.org/gems/weixin_rails_middleware

Example:　https://github.com/lanrion/weixin_rails_middleware_example

## Function

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

  It will create `config/initializers/weixin_rails_middleware.rb`

  Note: You need to checkout comments in file

  And

  Create `app/decorators/controllers/weixin_rails_middleware/weixin_controller_decorator.rb`

  Note: You need to overwrite the `reply` method. And there are two instance: `@weixin_message`,
  `@weixin_public_account(token_model instance if you setup, otherwise return nil)`

  Other

  Add a line: `WeixinRailsMiddleware::Engine, at: WeixinRailsMiddleware.config.engine_path` in `routes.rb`

## Helpers

  Please see detail in `reply_weixin_message_helper.rb`

## Weixin Server Api URl
  View helper `weixin_server_url(public_account=nil)`.
  if you using `token_string` default, pass with nothing, so it is `weixin_server_url`.

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

## Form Helper

  Custom `weixin_token_field`

  Usage: `f.weixin_token_field: weixin_token`

## Auto generate weixin_token method
  `WeiXinUniqueToken.generate(options={})`,`options` have `size` and `generator`
  we use `SecureRandom` to generate weixin_token, so it includes `hex, base64, random_bytes, urlsafe_base64, random_number, uuid`, default is `:hex`

  e.g. `WeiXinUniqueToken.generate(generator: "uuid")`

## XML parser
  We use `roxml` to generate XML and use `multi_xml` to parse `XML`, but we let them all use `nokogiri` plugin default.

## TODO

  * 添加微信自定义菜单
  * 多媒体资料上传

## 如何贡献代码

  * fork 到自己的github库，提交你的代码， 修改完之后，请同步更新到 weixin_rails_middlerware_example测试项目中。

  * 测试的话，需要开启服务器与微信对接，这种情况，请结合 weixin_rails_middlerware_example
  在`Gemfile`里修改 `gem 'weixin_rails_middleware', path: "home/weixin_rails_middlerware"`, 接着`bundle install`

  如果有更好的Idea，可以推荐一下。

