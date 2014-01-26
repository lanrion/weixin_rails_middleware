WeixinRailsMiddleware::Engine.routes.draw do
  get  'weixin/:weixin_token', to: 'weixin#index'
  post 'weixin/:weixin_token', to: 'weixin#reply'
end
