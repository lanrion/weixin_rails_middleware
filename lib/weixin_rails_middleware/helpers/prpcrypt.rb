# encoding: utf-8
require "weixin_rails_middleware/helpers/pkcs7_encoder"
module WeixinRailsMiddleware
  module Prpcrypt
    extend self

    # 对密文进行解密.
    # text 需要解密的密文
    def decrypt(aes_key, text, app_id)
      status = 200
      text   = Base64.decode64(text)
      text   = handle_cipher(:decrypt, aes_key, text)
      result = PKCS7Encoder.decode(text)
      content  = result[16...result.length]
      len_list = content[0...4].unpack("N")
      xml_len  = len_list[0]
      xml_content = content[4...4 + xml_len]
      from_app_id = content[xml_len + 4...content.size]
      # TODO: refactor
      if app_id != from_app_id
        Rails.logger.debug("#{__FILE__}:#{__LINE__} Failure because app_id != from_app_id")
        status = 401
      end
      [xml_content, status]
    end

    # 加密
    def encrypt(aes_key, text, app_id)
      text    = text.force_encoding("ASCII-8BIT")
      random  = SecureRandom.hex(8)
      msg_len = [text.length].pack("N")
      text    = "#{random}#{msg_len}#{text}#{app_id}"
      text    = PKCS7Encoder.encode(text)
      text    = handle_cipher(:encrypt, aes_key, text)
      Base64.encode64(text)
    end

    private
      def handle_cipher(action, aes_key, text)
        cipher = OpenSSL::Cipher.new('AES-256-CBC')
        cipher.send(action)
        cipher.padding = 0
        cipher.key = aes_key
        cipher.iv  = aes_key[0...16]
        cipher.update(text) + cipher.final
      end
  end
end
