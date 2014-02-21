module WeixinRailsMiddleware
  module UniqueToken
    def self.generate(options = {})
      # SecureRandom: hex, base64, random_bytes, urlsafe_base64, random_number, uuid
      generator_method_type = options.delete(:generator).try(:to_sym) || :hex
      generator_method      = SecureRandom.method(generator_method_type)
      token_size            = options.delete(:size).try(:to_i) || 12
      if generator_method_type != :uuid
        generator_method.call(token_size)
      else
        generator_method.call()
      end
    end
  end
end

WeiXinUniqueToken = WeixinRailsMiddleware::UniqueToken