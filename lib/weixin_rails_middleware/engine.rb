module WeixinRailsMiddleware
  class Engine < ::Rails::Engine
    include ConfigurationHelpers

    isolate_namespace WeixinRailsMiddleware
    engine_name :weixin_engine

  end
end
