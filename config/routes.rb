WeixinRailsMiddleware::Engine.routes.draw do
  get  'weixin/:weixin_token', to: 'weixin#index', as: :weixin_index
  post 'weixin/:weixin_token', to: 'weixin#reply', as: :weixin_reply
end
