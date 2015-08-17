# encoding: utf-8
# ref: https://github.com/wolfg1969/rack-weixin/lib/weixin/model.rb
require 'roxml'

module WeixinRailsMiddleware

  class ReplyMessage
    include ROXML
    xml_name :xml

    xml_accessor :ToUserName, :cdata   => true
    xml_accessor :FromUserName, :cdata => true
    xml_reader   :CreateTime, :as => Integer
    xml_reader   :MsgType, :cdata => true

    def initialize
      @CreateTime = Time.now.to_i
    end

    def to_xml
      super.to_xml(:encoding => 'UTF-8', :indent => 0, :save_with => 0)
    end
  end

  # <xml>
  # <ToUserName><![CDATA[toUser]]></ToUserName>
  # <FromUserName><![CDATA[fromUser]]></FromUserName>
  # <CreateTime>12345678</CreateTime>
  # <MsgType><![CDATA[text]]></MsgType>
  # <Content><![CDATA[Hello]]></Content>
  # </xml>

  class TextReplyMessage < ReplyMessage
    xml_accessor :Content, :cdata => true
    def initialize
      super
      @MsgType = 'text'
    end
  end

  class Music
    include ROXML
    xml_accessor :Title, :cdata => true
    xml_accessor :Description, :cdata => true
    xml_accessor :MusicUrl,   :cdata => true
    xml_accessor :HQMusicUrl, :cdata => true
  end

  # <xml>
  # <ToUserName><![CDATA[toUser]]></ToUserName>
  # <FromUserName><![CDATA[fromUser]]></FromUserName>
  # <CreateTime>12345678</CreateTime>
  # <MsgType><![CDATA[music]]></MsgType>
  # <Music>
  # <Title><![CDATA[TITLE]]></Title>
  # <Description><![CDATA[DESCRIPTION]]></Description>
  # <MusicUrl><![CDATA[MUSIC_Url]]></MusicUrl>
  # <HQMusicUrl><![CDATA[HQ_MUSIC_Url]]></HQMusicUrl>
  # <ThumbMediaId><![CDATA[media_id]]></ThumbMediaId>
  # </Music>
  # </xml>

  class MusicReplyMessage < ReplyMessage
    xml_accessor :Music, :as => Music
    def initialize
      super
      @MsgType = 'music'
    end
  end

  class Article
    include ROXML
    xml_accessor :Title, :cdata => true
    xml_accessor :Description, :cdata => true
    xml_accessor :PicUrl, :cdata => true
    xml_accessor :Url,    :cdata => true
  end

  # <xml>
  # <ToUserName><![CDATA[toUser]]></ToUserName>
  # <FromUserName><![CDATA[fromUser]]></FromUserName>
  # <CreateTime>12345678</CreateTime>
  # <MsgType><![CDATA[news]]></MsgType>
  # <ArticleCount>2</ArticleCount>
  # <Articles>
  # <item>
  # <Title><![CDATA[title1]]></Title>
  # <Description><![CDATA[description1]]></Description>
  # <PicUrl><![CDATA[picurl]]></PicUrl>
  # <Url><![CDATA[url]]></Url>
  # </item>
  # <item>
  # <Title><![CDATA[title]]></Title>
  # <Description><![CDATA[description]]></Description>
  # <PicUrl><![CDATA[picurl]]></PicUrl>
  # <Url><![CDATA[url]]></Url>
  # </item>
  # </Articles>
  # </xml>

  class NewsReplyMessage < ReplyMessage
    xml_accessor :ArticleCount, :as => Integer
    xml_accessor :Articles, :as => [Article], :in => 'Articles', :from => 'item'
    def initialize
      super
      @MsgType = 'news'
    end
  end

  # <xml>
  # <ToUserName><![CDATA[toUser]]></ToUserName>
  # <FromUserName><![CDATA[fromUser]]></FromUserName>
  # <CreateTime>12345678</CreateTime>
  # <MsgType><![CDATA[video]]></MsgType>
  # <Video>
  # <MediaId><![CDATA[media_id]]></MediaId>
  # <Title><![CDATA[title]]></Title>
  # <Description><![CDATA[description]]></Description>
  # </Video>
  # </xml>

  class Video
    include ROXML
    xml_accessor :MediaId, :cdata => true
    xml_accessor :Description, :cdata => true
    xml_accessor :Title, :cdata => true
  end

  class VideoReplyMessage < ReplyMessage
    xml_accessor :Video, :as => Video
    def initialize
      super
      @MsgType = 'video'
    end
  end

  # <xml>
  # <ToUserName><![CDATA[toUser]]></ToUserName>
  # <FromUserName><![CDATA[fromUser]]></FromUserName>
  # <CreateTime>12345678</CreateTime>
  # <MsgType><![CDATA[voice]]></MsgType>
  # <Voice>
  # <MediaId><![CDATA[media_id]]></MediaId>
  # </Voice>
  # </xml>
  class Voice
    include ROXML
    xml_accessor :MediaId, :cdata => true
  end

  class VoiceReplyMessage < ReplyMessage
    xml_accessor :Voice, :as => Voice
    def initialize
      super
      @MsgType = 'voice'
    end
  end

  # <xml>
  # <ToUserName><![CDATA[toUser]]></ToUserName>
  # <FromUserName><![CDATA[fromUser]]></FromUserName>
  # <CreateTime>12345678</CreateTime>
  # <MsgType><![CDATA[image]]></MsgType>
  # <Image>
  # <MediaId><![CDATA[media_id]]></MediaId>
  # </Image>
  # </xml>

  class Image
    include ROXML
    xml_accessor :MediaId, :cdata => true
  end

  class ImageReplyMessage < ReplyMessage
    xml_accessor :Image, :as => Image
    def initialize
      super
      @MsgType = 'image'
    end
  end

  # <xml>
  # <ToUserName><![CDATA[touser]]></ToUserName>
  # <FromUserName><![CDATA[fromuser]]></FromUserName>
  # <CreateTime>1399197672</CreateTime>
  # <MsgType><![CDATA[transfer_customer_service]]></MsgType>
  # </xml>
  class TransferCustomerServiceReplyMessage < ReplyMessage
    def initialize
      super
      @MsgType = 'transfer_customer_service'
    end
  end

  # 指定会话接入的客服账号
  class KfTransInfo
    include ROXML
    xml_accessor :KfAccount, :cdata => true
  end

  # <xml>
  #  <ToUserName><![CDATA[touser]]></ToUserName>
  #  <FromUserName><![CDATA[fromuser]]></FromUserName>
  #  <CreateTime>1399197672</CreateTime>
  #  <MsgType><![CDATA[transfer_customer_service]]></MsgType>
  #  <TransInfo>
  #   <KfAccount>test1@test</KfAccount>
  #  </TransInfo>
  # </xml>
  class TransferCustomerServiceWithTransInfoReplyMessage < ReplyMessage
    xml_accessor :TransInfo, :as => KfTransInfo
    def initialize
      super
      @MsgType = 'transfer_customer_service'
    end
  end

end
