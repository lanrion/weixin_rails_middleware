module WeixinRailsMiddleware
  class Configuration
    # use 'token_model': if the token is saved in SomeModel, then find token by it
    # use 'token_string': if the token is a String, just use it,
    attr_accessor :token_model, :token_column, :token_string, :engine_path

    def initialize
      @engine_path  = '/weixin_rails'
      @token_column = DEFAULT_TOKEN_COLUMN_NAME
    end

    def token_model_class
      token_model_c = token_model.constantize
      unless token_model_c.table_exists?
        raise "You don't have #{token_model_c.table_name} table"
      end
      token_model_c
    end

  end
end