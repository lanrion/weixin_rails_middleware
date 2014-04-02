require "weixin_rails_middleware/configuration"
require "weixin_rails_middleware/engine"
require "weixin_rails_middleware/models/message"
require "weixin_rails_middleware/models/reply_message"
require "weixin_rails_middleware/helpers/reply_weixin_message_helper"
require "weixin_rails_middleware/helpers/unique_token_helper"
require "weixin_rails_middleware/adapter"
require "weixin_rails_middleware/helpers/auto_generate_weixin_token_secret_key"

module WeixinRailsMiddleware

  DEFAULT_TOKEN_COLUMN_NAME = "weixin_token".freeze
  DEFAULT_WEIXIN_SECRET_KEY = "weixin_secret_key".freeze

end

