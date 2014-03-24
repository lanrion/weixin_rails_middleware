# WeixinRailsMiddleware

[![Gem Version](https://badge.fury.io/rb/weixin_rails_middleware.png)](http://badge.fury.io/rb/weixin_rails_middleware)

This project rocks and uses MIT-LICENSE.

It has already supported to Rails 3, Rails 4

https://rubygems.org/gems/weixin_rails_middleware

Example:　https://github.com/lanrion/weixin_rails_middleware_example

Rails 3 Example: https://github.com/lanrion/weixin_rails_3

高级API实现：[weixin_authorize](https://github.com/lanrion/weixin_authorize)

> If you want to develop weixin mobile app, I recommend [twitter_ratchet_rails](https://github.com/lanrion/twitter_ratchet_rails).


## Install

### Bundle

  Add `weixin_rails_middleware` into your `Gemfile`:

  `gem 'weixin_rails_middleware'` will install the last version

  If you want to use `master`:

  `gem 'weixin_rails_middleware', git: "https://github.com/lanrion/weixin_rails_middleware.git"`

  And `bundle intall`

### Init weixin_rails_middleware

  * Run `rails generate weixin_rails_middleware:install`

  1, It will create `config/initializers/weixin_rails_middleware.rb`

  ```ruby
  ## NOTE:
  ## If you config all them, it will use `weixin_token_string` default

  ## Config public_account_class if you SAVE public_account into database ##
  # Th first configure is fit for your weixin public_account is saved in database.
  # +public_account_class+ The class name that to save your public_account
  # config.public_account_class = ""

  ## Here configure is for you DON'T WANT TO SAVE your public account into database ##
  # Or the other configure is fit for only one weixin public_account
  # If you config `weixin_token_string`, so it will directly use it
  # config.weixin_token_string = '<%= SecureRandom.hex(12) %>'
  # using to weixin server url to validate the token can be trusted.
  # config.weixin_secret_string = '<%= WeiXinUniqueToken.generate(generator: :urlsafe_base64, size: 24) %>'

  ## Router configure ##
  # Default is "/", and recommend you use default directly.
  # config.engine_path = "/"

  ```

  2, Auto create `app/decorators/controllers/weixin_rails_middleware/weixin_controller_decorator.rb`

  Note: You need to overwrite the `reply` method. And there are two instance you can use: `@weixin_message`, `@weixin_public_account(return public_account instance if you setup "public_account", otherwise return nil)`

  3, Route

  Add a line: `WeixinRailsMiddleware::Engine, at: WeixinRailsMiddleware.config.engine_path` in `routes.rb`

  * If you save your public_account into database, you should do follow step:

  Run `rails generate weixin_rails_middleware:migration save_public_account_model_name`

  e.g.: `rails generate weixin_rails_middleware:migration public_acount`

  Will generate:

  ```ruby
  class AddWeixinSecretKeyAndWeixinTokenToPublicAccounts < ActiveRecord::Migration
    def self.up
      change_table(:public_accounts) do |t|
        t.string :weixin_secret_key, :null => false
        t.string :weixin_token,      :null => false
      end
      add_index :public_accounts, :weixin_secret_key, :unique => true
      add_index :public_accounts, :weixin_token,      :unique => true
    end

    def self.down
      # By default, we don't want to make any assumption about how to roll back a migration when your
      # model already existed. Please edit below which fields you would like to remove in this migration.
      raise ActiveRecord::IrreversibleMigration
    end
  end
  ```

  So, run `rake db:migrate` again. The `weixin_secret_key` value will auto generate before create. you don't have to operate it.

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

  * 图片回复: `reply_imgage_message(image)`。

  * 地理位置回复: 自定义需求。

  * 其他高级API实现：[weixin_authorize](https://github.com/lanrion/weixin_authorize)
    * 获取用户管理信息
    * 分组管理接口
    * 自定义菜单
    * 发送客服信息

  * 自定义菜单的实现

    * 数据库设计:

    ```ruby
    class CreateDiymenus < ActiveRecord::Migration
      def change
        create_table :diymenus do |t|
          t.integer :public_account_id
          t.integer :parent_id
          t.string :name
          t.string :key
          t.boolean :is_show
          t.string :url

          t.timestamps
        end
        add_index :diymenus, :public_account_id
        add_index :diymenus, :parent_id
        add_index :diymenus, :key

      end
    end

    ```

    * Diymenu model 层设计

    ```ruby
    class Diymenu < ActiveRecord::Base

      CLICK_TYPE = "click" # key
      VIEW_TYPE  = "view"  # url

      belongs_to :public_account

      has_many :sub_menus, ->{where(is_show: true).limit(5)}, class_name: "Diymenu", foreign_key: :parent_id

      def has_sub_menu?
        sub_menus.present?
      end

      # 优先为 click 类型
      def type
        key.present? ? CLICK_TYPE : VIEW_TYPE
      end

      def button_type(jbuilder)
        is_view_type? ? (jbuilder.url url) : (jbuilder.key key)
      end

      def is_view_type?
        type == VIEW_TYPE
      end
    end

    ```

    * PublicAccount Model 设计

    ```ruby
    class PublicAccount < ActiveRecord::Base

    # 自定义菜单
    has_many :diymenus, dependent: :destroy

    has_many :parent_menus, ->{includes(:sub_menus).where(parent_id: nil, is_show: true).limit(3)}, class_name: "Diymenu", foreign_key: :public_account_id

      def build_menu
        Jbuilder.encode do |json|
          json.button (parent_menus) do |menu|
            json.name menu.name
            if menu.sub_menus.present?
              json.sub_button(menu.sub_menus) do |sub_menu|
                json.type sub_menu.type
                json.name sub_menu.name
                sub_menu.button_type(json)
              end
            else
              json.type menu.type
              menu.button_type(json)
            end
          end
        end
      end
    end

    ```

    * Action层的用法

    ```ruby
    # 结合: https://github.com/lanrion/weixin_authorize(建议选用此gem的Redis存access_token方案)
    def generate_menu
      weixin_client ||= WeixinAuthorize::Client.new(@current_public_account.app_key, @current_public_account.app_secret)
      menu   = @current_public_account.build_menu
      result = weixin_client.create_menu(menu)
      set_error_message(result["errmsg"]) if result["errcode"] != 0
      redirect_to public_account_diymenus_path(@current_public_account)
    end

    ```

## Helpers

### Generate message helpers

  Please see details in [reply_weixin_message_helper.rb](https://github.com/lanrion/weixin_rails_middleware/blob/master/lib/weixin_rails_middleware/helpers/reply_weixin_message_helper.rb)

### Weixin server url, pass `weixin_secret_key` param
  `weixin_engine.weixin_index_url(public_account.weixin_secret_key)`

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
