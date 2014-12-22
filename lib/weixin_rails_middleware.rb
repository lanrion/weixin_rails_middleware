require 'roxml'
require 'multi_xml'
require 'ostruct'

require "weixin_rails_middleware/configuration"
require "weixin_rails_middleware/engine"

require "weixin_rails_middleware/models/encrypt_message"
require "weixin_rails_middleware/models/message"
require "weixin_rails_middleware/models/reply_message"

require "weixin_rails_middleware/helpers/prpcrypt"

require "weixin_rails_middleware/helpers/reply_weixin_message_helper"
require "weixin_rails_middleware/helpers/unique_token_helper"
require "weixin_rails_middleware/helpers/auto_generate_weixin_token_secret_key"

module WeixinRailsMiddleware

  autoload(:WexinAdapter, "weixin_rails_middleware/adapter/weixin_adapter")
  autoload(:SinglePublicAccount, "weixin_rails_middleware/adapter/single_public_account")
  autoload(:MultiplePublicAccount, "weixin_rails_middleware/adapter/multiple_public_account")

  DEFAULT_TOKEN_COLUMN_NAME = "weixin_token"
  DEFAULT_WEIXIN_SECRET_KEY = "weixin_secret_key"

end

