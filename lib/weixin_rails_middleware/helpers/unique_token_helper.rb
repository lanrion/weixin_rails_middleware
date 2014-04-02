module WeixinRailsMiddleware
  module UniqueTokenHelper
    def self.generate(options = {})
      # SecureRandom: hex, base64, random_bytes, urlsafe_base64, random_number, uuid
      generator_method_type = options.delete(:generator).try(:to_sym) || :hex
      generator_method      = SecureRandom.method(generator_method_type)
      token_size            = options.delete(:size).try(:to_i) || 12
      return generator_method.call if generator_method_type == :uuid
      generator_method.call(token_size)
    end
  end
end

WeiXinUniqueToken = WeixinRailsMiddleware::UniqueTokenHelper
