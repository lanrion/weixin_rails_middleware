# WeixinRailsMiddleware

This project rocks and uses MIT-LICENSE.

https://rubygems.org/gems/weixin_rails_middleware

Example:　https://github.com/lanrion/weixin_rails_middleware_example

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
