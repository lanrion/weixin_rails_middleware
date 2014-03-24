module WeixinRailsMiddleware

  class << self

    attr_accessor :configuration

    def config
      self.configuration ||= Configuration.new
    end

    def configure
      yield config if block_given?
    end

  end

  class Configuration
    # use 'public_account_class': if the token is saved in SomeModel, then find token by it
    # use 'weixin_token': if the token is a String, just use it,
    attr_accessor :public_account_class, :weixin_token_string, :weixin_secret_string

  end

  module ConfigurationHelpers
    extend ActiveSupport::Concern


    def weixin_token_string
      @weixin_token_string ||= WeixinRailsMiddleware.config.weixin_token_string.to_s
    end

    def token_model
      @public_account_class ||= WeixinRailsMiddleware.config.public_account_class
    end

    def weixin_secret_string
      @weixin_secret_string ||= WeixinRailsMiddleware.config.weixin_secret_string.to_s
    end

    def token_model_class
      if token_model.blank?
        raise "You need to config `public_account_class` in 'config/initializers/weixin_rails_middleware.rb'"
      end
      @token_model_class_name ||= token_model.constantize
    end
  end
end
