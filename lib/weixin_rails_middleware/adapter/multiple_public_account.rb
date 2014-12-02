# encoding: utf-8
module WeixinRailsMiddleware
  class MultiplePublicAccount < WexinAdapter

    def check_weixin_legality
      return render_authorize_result(404) if !is_weixin_secret_key_valid?
      super
    end

    # check the token from Weixin Service is exist in local store.
    def is_weixin_secret_key_valid?
      current_weixin_public_account.present?
    end

    def current_weixin_token
      current_weixin_public_account.try(DEFAULT_TOKEN_COLUMN_NAME)
    end

    # TODO: handle Exception
    def current_weixin_public_account
      @current_weixin_public_account ||= self.class.token_model_class.where("#{DEFAULT_WEIXIN_SECRET_KEY}" => weixin_secret_key).first
      @current_weixin_public_account.instance_eval do
        def aes_key
          WexinAdapter.decode64(encoding_aes_key)
        end
      end
      @current_weixin_public_account
    end

    def error_msg
      "#{__FILE__}:#{__LINE__}: RecordNotFound - Couldn't find #{self.class.token_model} with weixin_secret_key=#{weixin_secret_key}"
    end

  end
end
