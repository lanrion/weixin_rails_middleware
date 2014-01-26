# Use this hook to configure WeixinRailsMiddleware bahaviors.
WeixinRailsMiddleware.configure do |config|

  ## NOTE:
  ## if you config all them, it will use `token_string` default
  ##
  # Th FIRST configure
  # if you config `token_model`, it will use it to find_by_weixin_token
  # you must config a column name, `weixin_token` default
  # config.token_model  = "" # ActiveRecord subclass or other ORM subclass
  config.token_column = "weixin_token"

  # OR the SECOND configure
  # if you config `token_string`, so it will directly use it
  # config.token_string = "token string"

  # router
  # config.engine_path = "/weixin_rails"

end
