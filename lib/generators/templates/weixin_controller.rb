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
      reply_text_message("Your Message: #{@keyword}")
    end

    # <Location_X>23.134521</Location_X>
    # <Location_Y>113.358803</Location_Y>
    # <Scale>20</Scale>
    # <Label><![CDATA[位置信息]]></Label>
    def response_location_message(options={})
      @lx    = @weixin_message.Location_X
      @ly    = @weixin_message.Location_Y
      @scale = @weixin_message.Scale
      @label = @weixin_message.Label
      reply_text_message("Your Location: #{@lx}, #{@ly}, #{@scale}, #{@label}")
    end

    # <PicUrl><![CDATA[this is a url]]></PicUrl>
    # <MediaId><![CDATA[media_id]]></MediaId>
    def response_image_message(options={})
      @pic_url  = @weixin_message.PicUrl
      @media_id = @weixin_message.MediaId # 可以调用多媒体文件下载接口拉取数据。
      reply_text_message("回复图片信息")
    end

    # <Title><![CDATA[公众平台官网链接]]></Title>
    # <Description><![CDATA[公众平台官网链接]]></Description>
    # <Url><![CDATA[url]]></Url>
    def response_link_message(options={})
      @title = @weixin_message.Title
      @desc  = @weixin_message.Description
      @url   = @weixin_message.Url
      reply_text_message("回复链接信息")
    end

    def response_event_message(options={})
      event_type = @weixin_message.Event
      case event_type
      when "subscribe"   # 关注公众账号
        if @keyword.present?
          # 扫描带参数二维码事件: 1. 用户未关注时，进行关注后的事件推送
          reply_text_message("扫描带参数二维码事件: 1. 用户未关注时，进行关注后的事件推送, keyword: #{@keyword}")
        end
        reply_text_message("关注公众账号")
      when "unsubscribe" # 取消关注
        reply_text_message("取消关注")
      when "SCAN"        # 扫描带参数二维码事件: 2用户已关注时的事件推送
        reply_text_message("扫描带参数二维码事件: 2用户已关注时的事件推送, keyword: #{@keyword}")
      when "LOCATION"    # 上报地理位置事件
        @lat = @weixin_message.Latitude
        @lgt = @weixin_message.Longitude
        @precision = @weixin_message.Precision
        reply_text_message("Your Location: #{@lat}, #{@lgt}, #{@precision}")
      when "CLICK"       # 点击菜单拉取消息时的事件推送
        reply_text_message("你点击了: #{@keyword}")
      when "VIEW"        # 点击菜单跳转链接时的事件推送
        reply_text_message("你点击了: #{@keyword}")
      else
        reply_text_message("处理无法识别的事件")
      end

    end

    # <MediaId><![CDATA[media_id]]></MediaId>
    # <Format><![CDATA[Format]]></Format>
    def response_voice_message(options={})
      @media_id = @weixin_message.MediaId # 可以调用多媒体文件下载接口拉取数据。
      @format   = @weixin_message.format
      reply_text_message("回复语音信息: #{@keyword}")
    end

    # <MediaId><![CDATA[media_id]]></MediaId>
    # <ThumbMediaId><![CDATA[thumb_media_id]]></ThumbMediaId>
    def response_video_message(options={})
      @media_id = @weixin_message.MediaId # 可以调用多媒体文件下载接口拉取数据。
      # 视频消息缩略图的媒体id，可以调用多媒体文件下载接口拉取数据。
      @thumb_media_id = @weixin_message.ThumbMediaId
      reply_text_message("回复视频信息")
    end

    def set_keyword
      @keyword = @weixin_message.Content    || # 文本消息
                 @weixin_message.EventKey   || # 事件推送
                 @weixin_message.Recognition # 接收语音识别结果
    end

    # http://apidock.com/rails/ActionController/Base/default_url_options
    def default_url_options(options={})
      { weichat_id: @weixin_message.FromUserName }
    end
end
