# encoding: utf-8
# multi_xml will use Nokogiri if it is available
MultiXml.parser = :nokogiri

module WeixinRailsMiddleware

  class Message

    def initialize(hash)
      @source = OpenStruct.new(hash)
    end

    def method_missing(method, *args, &block)
      @source.send(method, *args, &block)
    end

    def CreateTime
      @source.CreateTime.to_i
    end

    def MsgId
      @source.MsgId.to_i
    end

    def self.factory(xml)
      hash = MultiXml.parse(xml)['xml']
      case hash['MsgType']
      when 'text'
        TextMessage.new(hash)
      when 'image'
        ImageMessage.new(hash)
      when 'location'
        LocationMessage.new(hash)
      when 'link'
        LinkMessage.new(hash)
      when 'event'
        EventMessage.new(hash)
      when 'voice'
        VoiceMessage.new(hash)
      when 'video'
        VideoMessage.new(hash)
      when 'shortvideo'
        ShortVideo.new(hash)
      else
        raise ArgumentError, 'Unknown Weixin Message'
      end
    end

  end

  # <xml>
  #     <ToUserName><![CDATA[toUser]]></ToUserName>
  #     <FromUserName><![CDATA[fromUser]]></FromUserName>
  #     <CreateTime>1348831860</CreateTime>
  #     <MsgType><![CDATA[text]]></MsgType>
  #     <Content><![CDATA[this is a test]]></Content>
  #     <MsgId>1234567890123456</MsgId>
  # </xml>
  TextMessage = Class.new(Message)

  # <xml>
  #     <ToUserName><![CDATA[toUser]]></ToUserName>
  #     <FromUserName><![CDATA[fromUser]]></FromUserName>
  #     <CreateTime>1348831860</CreateTime>
  #     <MsgType><![CDATA[image]]></MsgType>
  #     <PicUrl><![CDATA[this is a url]]></PicUrl>
  #     <MsgId>1234567890123456</MsgId>
  # </xml>
  ImageMessage = Class.new(Message)

  # <xml>
  #   <ToUserName><![CDATA[toUser]]></ToUserName>
  #   <FromUserName><![CDATA[fromUser]]></FromUserName>
  #   <CreateTime>1351776360</CreateTime>
  #   <MsgType><![CDATA[link]]></MsgType>
  #   <Title><![CDATA[公众平台官网链接]]></Title>
  #   <Description><![CDATA[公众平台官网链接]]></Description>
  #   <Url><![CDATA[url]]></Url>
  #   <MsgId>1234567890123456</MsgId>
  # </xml>
  LinkMessage = Class.new(Message)

  # <xml>
  #     <ToUserName><![CDATA[toUser]]></ToUserName>
  #     <FromUserName><![CDATA[FromUser]]></FromUserName>
  #     <CreateTime>123456789</CreateTime>
  #     <MsgType><![CDATA[event]]></MsgType>
  #     <Event><![CDATA[EVENT]]></Event>
  #     <EventKey><![CDATA[EVENTKEY]]></EventKey>
  # </xml>
  EventMessage = Class.new(Message)

  # <xml>
  #     <ToUserName><![CDATA[toUser]]></ToUserName>
  #     <FromUserName><![CDATA[fromUser]]></FromUserName>
  #     <CreateTime>1351776360</CreateTime>
  #     <MsgType><![CDATA[location]]></MsgType>
  #     <Location_X>23.134521</Location_X>
  #     <Location_Y>113.358803</Location_Y>
  #     <Scale>20</Scale>
  #     <Label><![CDATA[位置信息]]></Label>
  #     <MsgId>1234567890123456</MsgId>
  # </xml>
  class LocationMessage < Message

    def Location_X
      @source.Location_X.to_f
    end

    def Location_Y
      @source.Location_Y.to_f
    end

    def Scale
      @source.Scale.to_i
    end
  end

  # <xml>
  #   <ToUserName><![CDATA[toUser]]></ToUserName>
  #   <FromUserName><![CDATA[fromUser]]></FromUserName>
  #   <CreateTime>1376632760</CreateTime>
  #   <MsgType><![CDATA[voice]]></MsgType>
  #   <MediaId><![CDATA[Qyb0tgux6QLjhL6ipvFZJ-kUt2tcQtkn0BU365Vt3wUAtqfGam4QpZU35RXVhv6G]]></MediaId>
  #   <Format><![CDATA[amr]]></Format>
  #   <MsgId>5912592682802219078</MsgId>
  #   <Recognition><![CDATA[]]></Recognition>
  # </xml>
  class VoiceMessage < Message

    def MediaId
      @source.MediaId
    end

    def Format
      @source.Format
    end
  end

  # <xml>
  #   <ToUserName><![CDATA[toUser]]></ToUserName>
  #   <FromUserName><![CDATA[fromUser]]></FromUserName>
  #   <CreateTime>1376632994</CreateTime>
  #   <MsgType><![CDATA[video]]></MsgType>
  #   <MediaId><![CDATA[TAAGb6iS5LcZR1d5ICiZTWGWi6-Upic9tlWDpAKcNJA]]></MediaId>
  #   <ThumbMediaId><![CDATA[U-xulPW4kq6KKMWFNaBSPc65Bcgr7Qopwex0DfCeyQs]]></ThumbMediaId>
  #   <MsgId>5912593687824566343</MsgId>
  # </xml>
  class VideoMessage < Message

    def MediaId
      @source.MediaId
    end

    def ThumbMediaId
      @source.ThumbMediaId
    end
  end

  # <xml>
  #   <ToUserName><![CDATA[toUser]]></ToUserName>
  #   <FromUserName><![CDATA[fromUser]]></FromUserName>
  #   <CreateTime>1357290913</CreateTime>
  #   <MsgType><![CDATA[shortvideo]]></MsgType>
  #   <MediaId><![CDATA[media_id]]></MediaId>
  #   <ThumbMediaId><![CDATA[thumb_media_id]]></ThumbMediaId>
  #   <MsgId>1234567890123456</MsgId>
  # </xml>

  class ShortVideo < Message

    def MediaId
      @source.MediaId
    end

    def ThumbMediaId
      @source.ThumbMediaId
    end
  end

end
