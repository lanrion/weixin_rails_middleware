# encoding: utf-8
# 1: get weixin xml params
# @weixin_message
# 2: public_account_class instance if you setup, otherwise return nil
# @weixin_public_account
WeixinRailsMiddleware::WeixinController.class_eval do
  before_filter :set_keyword, only: :reply

  def reply
    render xml: send("response_#{@weixin_message.MsgType}_message", {})
  end

  private

    def response_text_message(options={})
      reply_text_message("Your Message: #{@weixin_message.Content}")
    end

    def response_location_message(options={})
      reply_text_message("Your Location: #{@weixin_message.Location_X}, #{@weixin_message.Location_Y}")
    end

    def response_image_message(options={})
      # image message handler
    end

    def response_link_message(options={})
      # link message handler
    end

    def response_event_message(options={})
      # event messge handler
    end

    def response_voice_message(options={})
      # voice message handler
    end

    def response_video_message(options={})
      # video message handler
    end
    def set_keyword
      @keyword = @weixin_message.Content    || # 文本消息
                 @weixin_message.EventKey   || # 事件推送
                 @weixin_message.Recognition # 接收语音识别结果
    end
end
