require 'middleman-core/extension'
require 'middleman-core/extensions'
require 'oc/web/core/helpers'

# Middleman extension for oc-web-core
module OC
  module Web
    module Core
      class Middleman < Middleman::Extension
        helpers OC::Web::Core::Helpers
      end
    end
  end
end

Middleman::Extensions.register(:oc_web_core, OC::Web::Core::Middleman)
