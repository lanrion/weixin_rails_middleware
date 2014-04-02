module WeixinRailsMiddleware
  class Engine < ::Rails::Engine

    isolate_namespace WeixinRailsMiddleware
    engine_name :weixin_engine

  end
end
