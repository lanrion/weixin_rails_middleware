WeixinRailsMiddleware::Engine.routes.draw do
  get  'weixin/:weixin_secret_key', to: 'weixin#index', as: :weixin_index
  post 'weixin/:weixin_secret_key', to: 'weixin#reply', as: :weixin_reply
end
