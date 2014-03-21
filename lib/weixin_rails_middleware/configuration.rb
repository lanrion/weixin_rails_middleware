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
    # use 'token_model': if the token is saved in SomeModel, then find token by it
    # use 'token_string': if the token is a String, just use it,
    attr_accessor :token_model, :token_column, :token_string, :engine_path

    def initialize
      @engine_path  = DEFAULT_ENGINE_PATH
      @token_column = DEFAULT_TOKEN_COLUMN_NAME
    end

  end

  module ConfigurationHelpers
    extend ActiveSupport::Concern

    def engine_path
      @engine_path ||= WeixinRailsMiddleware.config.engine_path
    end

    def token_string
      @token_string ||= WeixinRailsMiddleware.config.token_string.to_s
    end

    def token_column
      @token_column ||= WeixinRailsMiddleware.config.token_column
    end

    def token_model
      @token_model ||= WeixinRailsMiddleware.config.token_model
    end

    def is_default_engine_path?
      engine_path == DEFAULT_ENGINE_PATH # "/"
    end

    def token_model_class
      if token_model.blank?
        raise "You need to config `token_model` in 'config/initializers/weixin_rails_middleware.rb'"
      end
      @token_model_c ||= token_model.constantize
    end
  end
end
