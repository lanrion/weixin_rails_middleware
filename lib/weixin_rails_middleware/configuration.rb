module WeixinRailsMiddleware

  class << self

    attr_accessor :configuration

    def config
      self.configuration ||= Configuration.new
    end

    def configure
      yield config if block_given?
    end

  end

  class Configuration
    attr_accessor :public_account_class
    attr_accessor :weixin_secret_string, :weixin_token_string
    # 加密参数配置
    attr_accessor :encoding_aes_key, :app_id

    # 自定义场景
    attr_accessor :custom_adapter
  end

  module ConfigurationHelpers
    extend ActiveSupport::Concern

    [:weixin_secret_string, :weixin_token_string, :encoding_aes_key, :app_id].each do |attr_name|
      define_method attr_name do
        WeixinRailsMiddleware.config.send(attr_name).to_s
      end
    end

    def token_model
      @public_account_class ||= WeixinRailsMiddleware.config.public_account_class
    end

    def token_model_class
      if token_model.blank?
        raise "You need to config `public_account_class` in 'config/initializers/weixin_rails_middleware.rb'"
      end
      @token_model_class_name ||= token_model.to_s.constantize
    end

    def custom_adapter
      @custom_adapter ||= WeixinRailsMiddleware.config.custom_adapter.to_s
    end
  end
end
