module WeixinRailsMiddleware
  class Configuration
    # use 'token_model': if the token is saved in SomeModel, then find token by it
    # use 'token_string': if the token is a String, just use it,
    attr_accessor :token_model, :token_column, :token_string, :engine_path

    def initialize
      @engine_path  = DEFAULT_ENGINE_PATH
      @token_column = DEFAULT_TOKEN_COLUMN_NAME
    end

    def token_model_class
      if token_model.blank?
        raise "You need to config `token_model` in 'config/initializers/weixin_rails_middleware.rb'"
      end
      token_model_c = token_model.constantize
      token_model_c
    end

  end
end
