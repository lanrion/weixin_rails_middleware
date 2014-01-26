module WeixinRailsMiddleware
  class WeixinController < ApplicationController
    skip_before_filter :verify_authenticity_token
    before_action :check_weixin_params, only: [:index, :reply]

    def index
      render text: params[:echostr]
    end

    def reply
      render text: "weixin reply"
    end

    protected

      def check_weixin_params
        if check_weixin_token_valid?
          if !is_hexdigest?
            render text: "Forbidden", status: 403
          end
        end
      end

      # check the token from Weixin Service is exist in local store.
      def check_weixin_token_valid?
        if WeixinRailsMiddleware.config.token_string.blank?
          token_model  = WeixinRailsMiddleware.config.token_model_class
          token_column = WeixinRailsMiddleware.config.token_column
          token_model_instance = token_model.where("#{token_column}" => weixin_token).first
          if token_model_instance.blank?
            render text: "Forbidden", status: 403
            return false
          end
        else
          if weixin_token != WeixinRailsMiddleware.config.token_string
            render text: "Forbidden", status: 403
            return false
          end
        end
        true
      end

      def is_hexdigest?
        signature = params[:signature] || ''
        timestamp = params[:timestamp] || ''
        nonce     = params[:nonce] || ''
        current_signature = Digest::SHA1.hexdigest([weixin_token, timestamp, nonce].sort.join)
        return true if current_signature == signature
        false
      end

      def weixin_token
        @weixin_token ||= params[:weixin_token]
      end

  end
end
