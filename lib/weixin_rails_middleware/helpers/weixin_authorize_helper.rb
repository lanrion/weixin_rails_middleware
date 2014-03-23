module WeixinRailsMiddleware
  module WeixinAuthorizeHelper
    extend ActiveSupport::Concern

    protected

      def check_weixin_params
        check_weixin_secret_key_valid
        check_signature_valid
      end

      # check the token from Weixin Service is exist in local store.
      def check_weixin_secret_key_valid
        if weixin_token_string.blank?
          if current_weixin_public_account.blank?
            render text: "RecordNotFound - Couldn't find #{token_model} with weixin_secret_key=#{current_weixin_secret_key} ", status: 404
            return false
          end
        else
          if current_weixin_secret_key != weixin_secret_string
            render text: "WeixinSecretStringNotMatch", status: 403
            return false
          end
        end
        true
      end

      def check_signature_valid
        signature   = params[:signature] || ''
        timestamp   = params[:timestamp] || ''
        nonce       = params[:nonce]     || ''
        sort_params = [current_weixin_token, timestamp, nonce].sort.join
        current_signature = Digest::SHA1.hexdigest(sort_params)
        return true if current_signature == signature
        render text: "WeixinSignatureNotMatch", status: 403
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

