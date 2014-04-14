$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "weixin_rails_middleware/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "weixin_rails_middleware"
  s.version     = WeixinRailsMiddleware::VERSION
  s.authors     = ["lanrion"]
  s.email       = ["huaitao-deng@foxmail.com"]
  s.homepage    = "http://github.com/lanrion/weixin_rails_middleware"
  s.summary     = "weixin_rails_middleware for integration weixin"
  s.description = "weixin_rails_middleware for integration weixin develop"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency 'railties', '>= 3.1'
  s.add_dependency 'nokogiri', '>= 1.6.1'
  s.add_runtime_dependency 'rails', '>= 3.1'

  s.add_dependency 'multi_xml', '>= 0.5.2'
  s.add_dependency 'roxml'

end
