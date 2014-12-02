# encoding: utf-8
module WeixinRailsMiddleware
  class WexinAdapter
    extend ConfigurationHelpers

    attr_accessor :signature, :timestamp, :nonce, :echostr
    attr_accessor :weixin_secret_key

    def initialize(weixin_params)
      @weixin_secret_key = weixin_params[:weixin_secret_key]
      # 以下参数为什么加空字符串默认值的原因:
      # 微信偶尔会再重新发一次get请求，但是不会带上signature,timestamp,nonce的参数
      @signature = weixin_params[:signature] || ''
      @timestamp = weixin_params[:timestamp] || ''
      @nonce     = weixin_params[:nonce]     || ''
      @echostr   = weixin_params[:echostr]   || ''
    end

    def self.init_with(weixin_params)
      if custom_adapter.present?
        if custom_adapter.constantize.superclass != self
          raise "#{custom_adapter.to_s} must inherite WexinAdapter"
        end
        return custom_adapter.constantize.new(weixin_params)
      end
      if weixin_token_string.present?
        SinglePublicAccount.new(weixin_params)
      else
        MultiplePublicAccount.new(weixin_params)
      end
    end

    def check_weixin_legality
      return render_authorize_result(401, self.class.error_msg) if !is_signature_valid?
      render_authorize_result(200, echostr, true)
    end

    def is_signature_valid?
      sort_params = [current_weixin_token, timestamp, nonce].sort.join
      current_signature = Digest::SHA1.hexdigest(sort_params)
      return true if current_signature == signature
      false
    end

    def current_weixin_public_account
      raise NotImplementedError, "Subclasses must implement current_weixin_public_account method"
    end

    def current_weixin_token
      raise NotImplementedError, "Subclasses must implement current_weixin_token method"
    end

    def is_weixin_secret_key_valid?
      raise NotImplementedError, "Subclasses must implement is_weixin_secret_key_valid? method"
    end

    class << self
      def error_msg
        "#{__FILE__}:#{__LINE__}: Weixin signature NotMatch"
      end

      def decode64(encoding_aes)
        Base64.decode64("#{encoding_aes}=")
      end
    end

    private

      # render weixin server authorize results
      def render_authorize_result(status=401, text=nil, valid=false)
        text = text || error_msg
        Rails.logger.error(text) if status != 200
        {text: text, status: status, valid: valid}
      end

      def error_msg
        self.class.error_msg
      end
  end
end
