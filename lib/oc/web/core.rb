require 'oc/web/core/version'

module OC
  module Web
    module Core
      ROOT_PATH = File.expand_path(
        File.join(File.dirname(__FILE__), '../../..')
      )
      STYLESHEETS_PATH = File.join(ROOT_PATH, 'lib/assets/stylesheets')
      TEMPLATES_PATH = File.join(ROOT_PATH, 'templates')
    end
  end
end
