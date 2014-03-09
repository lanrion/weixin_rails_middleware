# Use this hook to configure WeixinRailsMiddleware bahaviors.
WeixinRailsMiddleware.configure do |config|

  ## NOTE:
  ## If you config all them, it will use `token_string` default
  ##
  # Th first configure is fit for your weixin public_account is saved in database.
  # +token_model+ and +token_column+ must in the same table.
  # +token_model+ The class name that to save your public_account
  # +token_column+ You can config a column name Optional, but you must have a column `weixin_token` default.
  # config.token_model  = ""
  # config.token_column = "weixin_token"

  # Or the other configure is fit for only one weixin public_account
  # If you config `token_string`, so it will directly use it
  # config.token_string = "token string"

  # Router
  # Default is "/", and recommend you use default directly.
  # config.engine_path = "/"

end
