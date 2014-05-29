require 'middleman-core/extension'
require 'middleman-core/extensions'

# Middleman extension for oc-web-core
module OC
  module Web
    module Core
      class Middleman < Middleman::Extension
        helpers do
          def oc_partial(name)
            open(
              File.join(
                File.dirname(__FILE__), '../../../../templates', "#{name}.html"
              )
            ).read
          end
        end
      end
    end
  end
end

Middleman::Extensions.register(:oc_web_core, OC::Web::Core::Middleman)
