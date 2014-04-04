module WeixinRailsMiddleware
  module ReplyWeixinMessageHelper

    # e.g.
    # reply_text_message(@weixin_message.ToUserName, @weixin_message.FromUserName, "Your Message: #{@weixin_message.Content}")
    # Or reply_text_message("Your Message: #{@weixin_message.Content}")
    def reply_text_message(from=nil, to=nil, content)
      message = TextReplyMessage.new
      message.FromUserName = from || @weixin_message.ToUserName
      message.ToUserName   = to   || @weixin_message.FromUserName
      message.Content      = content
      message.to_xml
    end

    def generate_music(title, desc, music_url, hq_music_url)
      music = Music.new
      music.Title       = title
      music.Description = desc
      music.MusicUrl    = music_url
      music.HQMusicUrl  = hq_music_url
      music
    end

    # music = generate_music
    def reply_music_message(from=nil, to=nil, music)
      message = MusicReplyMessage.new
      message.FromUserName = from || @weixin_message.ToUserName
      message.ToUserName   = to   || @weixin_message.FromUserName
      message.Music        = music
      message.to_xml
    end

    def generate_article(title, desc, pic_url, link_url)
      item = Article.new
      item.Title       = title
      item.Description = desc
      item.PicUrl = pic_url
      item.Url    = link_url
      item
    end

    # articles = [generate_article]
    def reply_news_message(from=nil, to=nil, articles)
      message = NewsReplyMessage.new
      message.FromUserName = from || @weixin_message.ToUserName
      message.ToUserName   = to   || @weixin_message.FromUserName
      message.Articles     = articles
      message.ArticleCount = articles.count
      message.to_xml
    end

    def generate_video(media_id, desc, title)
      video = Video.new
      video.MediaId = media_id
      video.Title   = title
      video.Description = desc
      video
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

    def reply_video_message(from=nil, to=nil, video)
      message = VideoReplyMessage.new
      message.FromUserName = from || @weixin_message.ToUserName
      message.ToUserName   = to   || @weixin_message.FromUserName
      message.Video = video
      message.to_xml
    end

    def generate_voice(media_id)
      voice = Voice.new
      voice.MediaId = media_id
      voice
    end

    def reply_voice_message(from=nil, to=nil, voice)
      message = VoiceReplyMessage.new
      message.FromUserName = from || @weixin_message.ToUserName
      message.ToUserName   = to   || @weixin_message.FromUserName
      message.Voice = voice
      message.to_xml
    end

    def generate_image(media_id)
      image = Image.new
      image.MediaId = media_id
      image
    end

    def reply_image_message(from=nil, to=nil, image)
      message = ImageReplyMessage.new
      message.FromUserName = from || @weixin_message.ToUserName
      message.ToUserName   = to   || @weixin_message.FromUserName
      message.Image = image
      message.to_xml
    end

  end
end
