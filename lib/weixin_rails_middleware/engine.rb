module WeixinRailsMiddleware
  class Engine < ::Rails::Engine
    include ConfigurationHelpers

    isolate_namespace WeixinRailsMiddleware
    engine_name :weixin_engine

    config.after_initialize do
      if token_model_class.present?
        token_model_class.send(:include, WeixinServerUrl::InstanceMethods)
      end
    end

  end
end
