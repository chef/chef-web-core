# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chef/web/core/version'

Gem::Specification.new do |spec|
  spec.name          = 'chef-web-core'
  spec.version       = Chef::Web::Core::VERSION
  spec.authors       = ['Christian Nunciato', 'Jon Ong', 'Nathan L Smith']
  spec.email         = ['vi@chef.io']
  spec.summary       = %q{Shared resources for Chef web properties}
  spec.homepage      = 'https://github.com/chef/chef-web-core'

  spec.files         = Dir['{lib/assets,lib/chef,lib/oc,vendor}/**/*', 'VERSION', 'LICENSE']
  spec.files.reject! { |fn| fn.include?('lib/assets/images/source') }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'foundation-rails', '5.5.1.1'
  spec.add_dependency 'compass-rails', '~> 3.1.0'
  spec.add_dependency 'sass-rails', '>= 3.2.5'
  spec.add_dependency 'sass', '>= 3.4.0', '< 4.0'
  spec.add_dependency 'nokogiri'

  spec.add_development_dependency 'bundler', '~> 1.6'
end
