module WeixinRailsMiddleware
  module AutoGenerateWeixinTokenSecretKey
    extend ActiveSupport::Concern

    included do

      before_create do
        # TODO: refactor
        self.weixin_secret_key =  generate_weixin_secret_key
        self.weixin_token      = WeiXinUniqueToken.generate
      end
    end

    private

    def generate_weixin_secret_key
      WeiXinUniqueToken.generate(generator: :urlsafe_base64, size: 24)
    end
  end
end
