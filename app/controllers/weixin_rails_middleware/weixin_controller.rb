module WeixinRailsMiddleware
  class WeixinController < ApplicationController
    include WeixinMessageHelper

    skip_before_filter :verify_authenticity_token
    before_action :check_weixin_params, only: [:index, :reply]
    before_action :set_weixin_public_account, :set_weixin_message, only: :reply

    def index
      render text: params[:echostr]
    end

    def reply
    end

    protected

      def check_weixin_params
        if check_weixin_token_valid?
          unless is_hexdigest?
            render text: "Forbidden", status: 403
          end
        end
      end

      # check the token from Weixin Service is exist in local store.
      def check_weixin_token_valid?
        token_string ? check_token_string : check_token_model_instance
      end

      def token_string
        WeixinRailsMiddleware.config.token_string
      end

      def check_token_string
        true
        if current_weixin_token != token_string
          render text: "Forbidden", status: 403
          false
        end      
      end

      def check_token_model_instance
        true
        if token_model_instance.blank?
          render text: "Forbidden", status: 403
          false
        end          
      end

      def is_hexdigest?
        t = weixin_token, timestamp, nonce
        current_signature = Digest::SHA1.hexdigest(t.sort.join)
        return true if current_signature == signature
        false
      end

      [:signature, :timestamp, :nonce, :weixin_token].each do |e|
        define_method e do
          params[e]
        end
      end

      def current_weixin_token
        @weixin_token = params[:weixin_token]
      end

      def token_model_instance
        token_model  = WeixinRailsMiddleware.config.token_model_class
        token_column = WeixinRailsMiddleware.config.token_column
        token_model_instance = token_model.where("#{token_column}" => current_weixin_token).first
        token_model_instance
      end

      # e.g. will generate +@weixin_public_account+
      def set_weixin_public_account
        return nil if WeixinRailsMiddleware.config.token_string.present?
        @weixin_public_account ||= token_model_instance
      end

      def set_weixin_message
        # Get the current_message
        @weixin_message ||= current_weixin_message
      end

      # take the weixin params
      def current_weixin_params
        request.body.read
      end

      # return a message class with current_weixin_params
      def current_weixin_message
        Message.factory(current_weixin_params)
      end

  end
end
