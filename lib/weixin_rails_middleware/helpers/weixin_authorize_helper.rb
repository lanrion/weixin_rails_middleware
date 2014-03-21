module WeixinRailsMiddleware
  module WeixinAuthorizeHelper
    extend ActiveSupport::Concern

    protected

      def check_weixin_params
        if is_weixin_secret_key_valid? && is_signature_invalid?
          render text: "Forbidden", status: 403
        end
      end

      # check the token from Weixin Service is exist in local store.
      def is_weixin_secret_key_valid?
        if weixin_token_string.blank?
          if current_weixin_public_account.blank?
            render text: "Forbidden", status: 403
            return false
          end
        else
          if current_weixin_secret_key != weixin_secret_string
            render text: "Forbidden", status: 403
            return false
          end
        end
        true
      end

      def is_signature_invalid?
        signature   = params[:signature] || ''
        timestamp   = params[:timestamp] || ''
        nonce       = params[:nonce]     || ''
        sort_params = [current_weixin_token, timestamp, nonce].sort.join
        current_signature = Digest::SHA1.hexdigest(sort_params)
        return true if current_signature != signature
        false
      end

      def current_weixin_secret_key
        @weixin_secret_key = params[:weixin_secret_key]
      end

      def current_weixin_token
        return weixin_token_string if weixin_token_string.present?
        current_weixin_public_account.try(DEFAULT_TOKEN_COLUMN_NAME)
      end

      def current_weixin_public_account
        @current_weixin_public_account = token_model_class.where("#{DEFAULT_WEIXIN_SECRET_KEY}" => current_weixin_secret_key).first
      end

      # return a message class with current_weixin_params
      def current_weixin_message
        Message.factory(request.body.read)
      end

  end
end

