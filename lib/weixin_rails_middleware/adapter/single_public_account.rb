# encoding: utf-8
module WeixinRailsMiddleware
  class SinglePublicAccount < WexinAdapter

    def check_weixin_legality
      return render_authorize_result if !is_weixin_secret_key_valid?
      super
    end

    def is_weixin_secret_key_valid?
      weixin_secret_key == self.class.weixin_secret_string
    end

    def current_weixin_token
      self.class.weixin_token_string
    end

    def current_weixin_public_account
      @current_weixin_public_account ||= OpenStruct.new(
                      weixin_secret_string: self.class.weixin_secret_string,
                      weixin_token_string: self.class.weixin_token_string,
                      app_id: self.class.app_id)
      @current_weixin_public_account.instance_eval do
        def aes_key
          WexinAdapter.decode64(WexinAdapter.encoding_aes_key)
        end
      end
      @current_weixin_public_account
    end

    def error_msg
      "#{__FILE__}:#{__LINE__}: Weixin secret string NotMatch."
    end

  end
end
