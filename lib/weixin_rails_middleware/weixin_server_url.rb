# TODO: added weixin_server_url for User
# if config +token_model+, e.g. user = User.first; user.weixin_server_url
# if config +token_string+, e.g. weixin_server_url
# a public url looks like: weixin_server_url
module WeixinRailsMiddleware
  module WeixinServerUrl
    extend ActiveSupport::Concern

    included do
      def weixin_server_url
        "http test"
      end
    end
  end
end
