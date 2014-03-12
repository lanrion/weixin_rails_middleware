module WeixinRailsMiddleware
  module WeixinAuthorizeHelper
    extend ActiveSupport::Concern

    protected

      def check_weixin_params
        if check_weixin_token_valid? && !is_hexdigest?
          render text: "Forbidden", status: 403
        end
      end

      # check the token from Weixin Service is exist in local store.
      def check_weixin_token_valid?
        if token_string.blank?
          if token_model_instance.blank?
            render text: "Forbidden", status: 403
            return false
          end
        else
          if current_weixin_token != token_string
            render text: "Forbidden", status: 403
            return false
          end
        end
        true
      end

      def is_hexdigest?
        signature = params[:signature] || ''
        timestamp = params[:timestamp] || ''
        nonce     = params[:nonce]     || ''
        current_signature = Digest::SHA1.hexdigest([current_weixin_token, timestamp, nonce].sort.join)
        return true if current_signature == signature
        false
      end

      def current_weixin_token
        @weixin_token = params[:weixin_token]
      end

      def token_model_instance
        token_model_instance = token_model_class.where("#{token_column}" => current_weixin_token).first
        token_model_instance
      end

      # return a message class with current_weixin_params
      def current_weixin_message
        Message.factory(request.body.read)
      end

  end
end

