WeixinRailsMiddleware::Engine.routes.draw do
  match 'weixin/:weixin_token', to: 'weixin#index', via: :get
  match 'weixin/:weixin_token', to: 'weixin#reply', via: :post
end
