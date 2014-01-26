WeixinRailsMiddleware::WeixinController.class_eval do

  def reply
    root          = Nokogiri::XML(request.body.read).root
    @receiver     = root.xpath("ToUserName").children.text
    @sender       = root.xpath("FromUserName").children.text
    @send_time    = Time.at(root.xpath("CreateTime").text.to_i)
    @keyword      = root.xpath("Content").children.text
    @message_type = root.xpath("MsgType").children.text
    @message_id   = root.xpath("MsgId").text.to_i
  end
end
