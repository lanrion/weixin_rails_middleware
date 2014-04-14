# WeixinRailsMiddleware

[![Gem Version](https://badge.fury.io/rb/weixin_rails_middleware.png)](http://badge.fury.io/rb/weixin_rails_middleware)

This project rocks and uses MIT-LICENSE.

https://rubygems.org/gems/weixin_rails_middleware

## 使用特别说明

### 支持Rails版本

最新版本已经支持 Rails 3, Rails 4

### 相关gem推荐使用

* **微信高级功能** 请务必结合高级API实现：[weixin_authorize](https://github.com/lanrion/weixin_authorize)

* **Wap Ratchet 框架** 推荐使用： [twitter_ratchet_rails](https://github.com/lanrion/twitter_ratchet_rails)

## [查看 Wiki：](https://github.com/lanrion/weixin_rails_middleware/wiki)

* [Getting Start](https://github.com/lanrion/weixin_rails_middleware/wiki/Getting-Start)

* [实现自定义菜单](https://github.com/lanrion/weixin_rails_middleware/wiki/DIY-menu)

* [生成微信信息使用方法](https://github.com/lanrion/weixin_rails_middleware/wiki/Generate-message-helpers)


## 参考示例

Rails 4: https://github.com/lanrion/weixin_rails_middleware_example

Rails 3: https://github.com/lanrion/weixin_rails_3

## 实现功能

  * 自动验证微信请求。

  * 无需拼接XML格式，只需要使用 `ReplyWeixinMessageHelper` 辅助方法，即可快速回复。
    使用方法: ` render xml: reply_text_message("Your Message: #{current_message.Content}") `

  * 支持自定义token，适合一个用户使用。

  * 支持多用户token: 适合多用户注册网站，每个用户有不同的token，通过 `weixin_rails_middleware.rb` 配置好存储token的Model与字段名，即可。

  * 文本回复: `reply_text_message(content)`。

  * 音乐回复: `reply_music_message(music)`, `generate_music(title, desc, music_url, hq_music_url)`。

  * 图文回复: `reply_news_message(articles)`, `generate_article(title, desc, pic_url, link_url)`。

  * 视频回复: `reply_video_message(video)`。

  * 语音回复: `reply_voice_message(voice)`。

  * 图片回复: `reply_image_message(image)`。

  * 地理位置回复: 自定义需求。

  * 其他高级API实现：[weixin_authorize](https://github.com/lanrion/weixin_authorize)
    * 获取用户管理信息
    * 分组管理接口
    * 自定义菜单
    * 发送客服信息
    * 生成带参数的二维码
    * 上传下载多媒体文件

## 如何测试？

  安装 [ngrok](https://ngrok.com)，解压后跑 `ngrok 4000`

  然后会产生以下信息：

  ```
  Tunnel Status                 online
  Version                       1.6/1.5
  Forwarding                    http://e0ede89.ngrok.com -> 127.0.0.1:4000
  Forwarding                    https://e0ede89.ngrok.com -> 127.0.0.1:4000
  Web Interface                 127.0.0.1:4040
  # Conn                        67
  Avg Conn Time                 839.50ms

  ```

 域名为 `http://e0ede89.ngrok.com`。 注意非付费版本域名每次会随机生成，不是固定的。


## 贡献你的代码

  1. Fork it
  2. Create your feature branch (`git checkout -b my-new-feature`).
  3. Commit your changes (`git commit -am 'Add some feature'`).
  4. Push to the branch (`git push origin my-new-feature`).
  5. Create new Pull Request.
  6. Test with [weixin_rails_middleware_example](https://github.com/lanrion/weixin_rails_middleware_example), and push your changes.

## Bugs 和反馈

 如果你发现有出现任何的bug，请在 https://github.com/lanrion/weixin_rails_middleware/issues 记录你的bug详细信息，

 或者在 [Ruby China](http://ruby-china.org/) 开帖 [@ruby_sky](http://ruby-china.org/ruby_sky), 个人邮箱回复速度相对慢.

## 推荐阅读

  * [浅析微信信息信息接收与信息回复](https://gist.github.com/lanrion/9479631)

## 参考致谢
  在微信回复信息XML的封装方法，借鉴了 [rack-weixin](https://github.com/wolfg1969/rack-weixin) 实现，特此感谢！
