module WeixinRailsMiddleware
  module AutoGenerateWeixinTokenSecretKey
    extend ActiveSupport::Concern

    included do

      before_create do
        self.weixin_secret_key = generate_weixin_secret_key
        self.weixin_token      = WeiXinUniqueToken.generate
      end
    end

    private

      def generate_weixin_secret_key
        WeiXinUniqueToken.generate(generator: :urlsafe_base64, size: 32).downcase
      end
  end
end
