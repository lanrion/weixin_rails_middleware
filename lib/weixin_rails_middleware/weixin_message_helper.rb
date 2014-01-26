module WeixinRailsMiddleware
  module WeixinMessageHelper

    def reply_text_message(from, to, content)
      message = TextReplyMessage.new
      message.ToUserName   = to
      message.FromUserName = from
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
    def reply_music_message(from, to, music)
      message = MusicReplyMessage.new
      message.ToUserName   = to
      message.FromUserName = from
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
    def reply_news_message(from, to, articles)
      message = NewsReplyMessage.new
      message.ToUserName   = to
      message.FromUserName = from
      message.Articles     = articles
      message.ArticleCount = articles.count
      message.to_xml
    end

    def generate_video(media_id, desc, title)
      video = Video.new
      video.MediaId     = media_id
      video.Description = desc
      video.Title = title
      vodeo
    end

    def replay_video_message(video)
      message = VideoReplyMessage.new
      message.Video = video
      message.to_xml
    end

    def generate_voice(media_id)
      voice = Voice.new
      voice.MediaId = media_id
      voice
    end

    def reply_voice_message(voice)
      message = VoiceReplyMessage.new
      message.Voice = voice
      message.to_xml
    end

    def generate_image(media_id)
      image = Image.new
      image.MediaId = media_id
      image
    end

    def reply_imgage_message(image)
      message = ImageReplyMessage.new
      message.Image = image
    end

    # take the weixin params
    def current_weixin_params
      @current_weixin_params = request.body.read
      # for test
       # %(
       #  <xml>
       #      <ToUserName><![CDATA[to]]></ToUserName>
       #      <FromUserName><![CDATA[from]]></FromUserName>
       #      <CreateTime>1360391199</CreateTime>
       #      <MsgType><![CDATA[text]]></MsgType>
       #      <Content><![CDATA[Hello2BizUser]]></Content>
       #      <MsgId>5842835709471227904</MsgId>
       #  </xml>
       #  )
    end

    # return a message class with current_weixin_params
    def current_weixin_message
      @current_weixin_message = Message.factory(current_weixin_params)
    end

    def current_message_type
      @message_type = current_weixin_message.MsgType
    end

    def current_message_sender
      @message_sender = current_weixin_message.FromUserName
    end

    def current_message_receiver
      @message_receiver = current_weixin_message.ToUserName
    end

  end
end