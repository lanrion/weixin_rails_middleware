module WeixinRailsMiddleware
  class WeixinController < ActionController::Base
    include ReplyWeixinMessageHelper

    skip_before_filter :verify_authenticity_token
    before_filter :initialize_adapter, :check_weixin_legality, only: [:index, :reply]
    before_filter :set_weixin_public_account, :set_weixin_message, only: :reply

    def index
    end

    def reply
    end

    protected

      def initialize_adapter
        @weixin_adapter ||= Adapter::WexinAdapter.init_with(params)
      end

      def check_weixin_legality
        check_result = @weixin_adapter.check_weixin_legality
        valid = check_result.delete(:valid)
        render check_result if action_name == "index"
        return valid
      end

      ## Callback
      # e.g. will generate +@weixin_public_account+
      def set_weixin_public_account
        @weixin_public_account ||= @weixin_adapter.current_weixin_public_account
      end

      def set_weixin_message
        # Get the current weixin message
        @weixin_message ||= Message.factory(request.body.read)
      end

  end
end
