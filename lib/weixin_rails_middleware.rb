require "weixin_rails_middleware/configuration"
require "weixin_rails_middleware/engine"
require "weixin_rails_middleware/models/message"
require "weixin_rails_middleware/models/reply_message"
require "weixin_rails_middleware/helpers/reply_weixin_message_helper"
require "weixin_rails_middleware/helpers/weixin_token_form_helper"
require "weixin_rails_middleware/helpers/unique_token_helper"
require "weixin_rails_middleware/helpers/weixin_server_url"
require "weixin_rails_middleware/helpers/weixin_authorize_helper"

module WeixinRailsMiddleware

  DEFAULT_TOKEN_COLUMN_NAME = "weixin_token".freeze
  DEFAULT_ENGINE_PATH       = "/".freeze

  class << self

    attr_accessor :configuration

    def config
      self.configuration ||= Configuration.new
    end

    def configure
      yield config if block_given?
    end

  end

end

