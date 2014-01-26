WeixinRailsMiddleware::WeixinController.class_eval do

  def reply
    # Get the current_message
    current_message = current_weixin_message

    case current_message.MsgType
    when 'text'
      # text message handler
      # render xml: reply_text_message("ToUserName", "FromUserName", "your Message")
    when 'image'
      # image message handler
    when 'location'
      # location message handler
    when 'link'
      # link message handler
    when 'event'
      # event messge handler
    when 'voice'
      # voice message handler
    when 'video'
      # video message handler
    else
      render xml: reply_text_message(current_message.ToUserName, current_message.FromUserName, 'Unknow message')
    end
  end
end
