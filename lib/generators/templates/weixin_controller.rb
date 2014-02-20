WeixinRailsMiddleware::WeixinController.class_eval do

  # There are two instance: @weixin_message,
  # @weixin_public_account(token_model instance if you setup, otherwise return nil)
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
end
