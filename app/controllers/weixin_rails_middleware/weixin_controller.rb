module WeixinRailsMiddleware
  class WeixinController < ActionController::Base
    include ReplyWeixinMessageHelper
    include ConfigurationHelpers
    include WeixinAuthorizeHelper

    skip_before_filter :verify_authenticity_token
    before_filter :check_weixin_params, only: [:index, :reply]
    before_filter :set_weixin_public_account, :set_weixin_message, only: :reply

    def index
      render text: params[:echostr]
    end

    def reply
    end

    protected

      ## Callback
      # e.g. will generate +@weixin_public_account+
      def set_weixin_public_account
        return nil if weixin_token_string.present?
        @weixin_public_account ||= current_weixin_public_account
      end

      def set_weixin_message
        # Get the current_message
        @weixin_message ||= current_weixin_message
      end

  end
end
