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



