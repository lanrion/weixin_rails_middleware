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
      nil
    end

    def error_msg
      "#{__FILE__}:#{__LINE__}: Weixin secret string NotMatch."
    end

  end
end
