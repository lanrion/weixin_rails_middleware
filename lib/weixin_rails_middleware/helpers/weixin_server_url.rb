# TODO: added weixin_server_url for User
# if config +token_model+, e.g. user = User.first; user.weixin_server_url
# if config +token_string+, e.g. weixin_server_url
# a public url looks like: weixin_server_url
module WeixinRailsMiddleware
  module WeixinServerUrl
    extend ActiveSupport::Concern
    include ConfigurationHelpers

    included do
      def weixin_server_url(public_account=nil)
        raise "You need pass a public_account instance." if token_string.blank? && public_account.blank?
        if public_account.present?
          weixin_server_url_with_public_account(public_account)
        else
          weixin_server_url_without_public_account(public_account)
        end
      end
    end

    private

      def weixin_server_url_with_public_account(public_account)
        base_host_url + current_token(public_account)
      end

      def weixin_server_url_without_public_account
        base_host_url + token_string
      end

      def current_token(public_account)
        if public_account.blank?
          token_string
        else
          public_account.try(token_column)
        end
      end

      def base_host_url
        host_url = request.base_url
        if is_default_engine_path? # "/"
          "#{host_url}/weixin/"
        else
          "#{host_url}/#{engine_path}/weixin/"
        end
      end
  end
end

ActionView::Base.send :include, WeixinRailsMiddleware::WeixinServerUrl
