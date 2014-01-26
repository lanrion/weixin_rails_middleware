# Rails::Generators::Base dont need a name
# Rails::Generators::NamedBase need a name
module WeixinRailsMiddleware
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)

      desc 'Creates a Dashing initializer for your application.'

      def install
        route 'mount WeixinRailsMiddleware::Engine, at: WeixinRailsMiddleware.config.engine_path'
      end

      def copy_initializer
        template 'initializer.rb', 'config/initializers/weixin_rails_middleware.rb'
      end

      def configure_application
        application <<-APP
    # Load application's model / class decorators
    Decorators.register! Rails.root
        APP
      end

      def copy_decorators
        template 'weixin_controller.rb', 'app/decorators/controllers/weixin_rails_middleware/weixin_controller_decorator.rb'
      end

    end
  end
end

# rails generate weixin_rails_middleware:install



