require 'rails/generators/active_record'

module WeixinRailsMiddleware
  module Generators
    class MigrationGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)

      desc 'Adds a Wexin Secret Key for your application.'

      def create_migration_file
        migration_template "add_weixin_secret_key.rb", "db/migrate/add_weixin_secret_key_to_#{plural_name}.rb"
      end

    end
  end
end
