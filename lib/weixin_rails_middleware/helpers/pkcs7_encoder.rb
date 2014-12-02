# encoding: utf-8

module WeixinRailsMiddleware
  module PKCS7Encoder
    extend self

    BLOCK_SIZE = 32

    def decode(text)
      pad = text[-1].ord
      pad = 0 if (pad < 1 || pad > BLOCK_SIZE)
      size = text.size - pad
      text[0...size]
    end

    # 对需要加密的明文进行填充补位
    # 返回补齐明文字符串
    def encode(text)
      # 计算需要填充的位数
      amount_to_pad = BLOCK_SIZE - (text.length % BLOCK_SIZE)
      amount_to_pad = BLOCK_SIZE if amount_to_pad == 0
      # 获得补位所用的字符
      pad_chr = amount_to_pad.chr
      "#{text}#{pad_chr * amount_to_pad}"
    end

  end
end
