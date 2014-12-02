# encoding: utf-8
# 标准的回包
# <xml>
#   <Encrypt><![CDATA[msg_encrypt]]></Encrypt>
#   <MsgSignature><![CDATA[msg_signature]]></MsgSignature>
#   <TimeStamp>timestamp</TimeStamp>
#   <Nonce><![CDATA[nonce]]></Nonce>
# </xml>

module WeixinRailsMiddleware
  class EncryptMessage
    include ROXML
    xml_name :xml

    xml_accessor :Encrypt, :cdata => true
    xml_accessor :Nonce, :cdata => true
    xml_accessor :TimeStamp, :as => Integer
    xml_accessor :MsgSignature, :cdata => true

    def to_xml
      super.to_xml(:encoding => 'UTF-8', :indent => 0, :save_with => 0)
    end
  end
end
