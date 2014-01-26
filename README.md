# WeixinRailsMiddleware

This project rocks and uses MIT-LICENSE.


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
