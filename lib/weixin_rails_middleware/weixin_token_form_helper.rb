# custom weixin_token_field
# usage: +f.weixin_token_field: weixin_token+
module ActionView
  module Helpers
    module Tags # :nodoc:
      class WeixinTokenField < TextField # :nodoc:
        def render
          # custom weixin_token value
          # TODO: +value+ maybe use another gerenate way
          @options = {value: @options.fetch("value") { value_before_type_cast(object) } || Time.now.to_i }.merge!(@options)
          @options["type"]="text"
          super
        end
      end
    end # end of Tags

    module FormHelper
      extend ActiveSupport::Concern
      def weixin_token_field(object_name, method, options = {})
        Tags::WeixinTokenField.new(object_name, method, self, options).render
      end
    end # end of FormHelper

    class FormBuilder
      selector = :weixin_token_field
      class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
        def #{selector}(method, options = {})  # def text_field(method, options = {})
          @template.send(                      #   @template.send(
            #{selector.inspect},               #     "text_field",
            @object_name,                      #     @object_name,
            method,                            #     method,
            objectify_options(options))        #     objectify_options(options))
        end                                    # end
      RUBY_EVAL
    end # end of FormHelper

  end # HELPERS
end
