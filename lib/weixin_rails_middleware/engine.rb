module WeixinRailsMiddleware
  class Engine < ::Rails::Engine
    include ConfigurationHelpers

    isolate_namespace WeixinRailsMiddleware
    engine_name :weixin_engine

    config.after_initialize do
      token_model_callback if token_model.present?
    end

    private

      def token_model_callback
        token_model_class.class_eval do
          validates :weixin_secret_key, :weixin_token, presence: true, uniqueness: true
          before_create do
            # TODO: refactor
            self.weixin_secret_key = WeiXinUniqueToken.generate(generator: :urlsafe_base64, size: 24) if weixin_secret_key.blank?
            self.weixin_token = WeiXinUniqueToken.generate if weixin_token.blank?
          end
        end
      end

  end
end
