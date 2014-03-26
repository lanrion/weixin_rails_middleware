# WeixinRailsMiddleware

[![Gem Version](https://badge.fury.io/rb/weixin_rails_middleware.png)](http://badge.fury.io/rb/weixin_rails_middleware)

This project rocks and uses MIT-LICENSE.

It has already supported to Rails 3, Rails 4

[Wiki](https://github.com/lanrion/weixin_rails_middleware/wiki)

高级API实现：[weixin_authorize](https://github.com/lanrion/weixin_authorize)

https://rubygems.org/gems/weixin_rails_middleware

## Example

Rails 4: https://github.com/lanrion/weixin_rails_middleware_example

Rails 3: https://github.com/lanrion/weixin_rails_3

> If you want to develop weixin mobile app, I recommend [twitter_ratchet_rails](https://github.com/lanrion/twitter_ratchet_rails).

## Functions

  * 自动验证微信请求。

  * 无需拼接XML格式，只需要使用 `ReplyWeixinMessageHelper` 辅助方法，即可快速回复。
    使用方法: ` render xml: reply_text_message("Your Message: #{current_message.Content}") `

  * 支持自定义token，适合一个用户使用。

  * 支持多用户token: 适合多用户注册网站，每个用户有不同的token，通过 `weixin_rails_middleware.rb` 配置好存储token的Model与字段名，即可。

  * 文本回复: `reply_text_message(content)`。

  * 音乐回复: `reply_music_message(music)`, `generate_music(title, desc, music_url, hq_music_url)`。

  * 图文回复: `reply_news_message(articles)`, `generate_article(title, desc, pic_url, link_url)`。

  * 视频回复: `replay_video_message(video)`。

  * 语音回复: `reply_voice_message(voice)`。

  * 图片回复: `reply_image_message(image)`。

  * 地理位置回复: 自定义需求。

  * 其他高级API实现：[weixin_authorize](https://github.com/lanrion/weixin_authorize)
    * 获取用户管理信息
    * 分组管理接口
    * 自定义菜单
    * 发送客服信息

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

## How to upgrade.
  Pending

## Contributing

  1. Fork it
  2. Create your feature branch (`git checkout -b my-new-feature`).
  3. Commit your changes (`git commit -am 'Add some feature'`).
  4. Push to the branch (`git push origin my-new-feature`).
  5. Create new Pull Request.
  6. Test with [weixin_rails_middleware_example](https://github.com/lanrion/weixin_rails_middleware_example), and push your changes.

## Bugs and Feedback
  If you discover any bugs, please describe it in the issues tracker, including Rails and weixin_rails_middleware versions.

  Or contact me <huatiaodeng@gmail.com>, <huaitao-deng@foxmail.com>, or in [Ruby China](http://ruby-china.org/) [ruby_sky](http://ruby-china.org/ruby_sky)

## Recommended articles
  * [浅析微信信息信息接收与信息回复](https://gist.github.com/lanrion/9479631)
