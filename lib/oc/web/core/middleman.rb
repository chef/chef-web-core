require 'middleman-core/extension'
require 'middleman-core/extensions'

# Middleman extension for oc-web-core
module OC
  module Web
    module Core
      class Middleman < Middleman::Extension
        helpers do
          # Load a partial from templates/#{name}.html
          def oc_partial(name)
            open(
              File.join(
                File.dirname(__FILE__), '../../../../templates', "#{name}.html"
              )
            ).read
          end

          # A title tag
          def oc_title_tag(text = nil)
            "<title>#{text}#{text.present? ? ' | ' : ''}Chef</title>"
          end
        end
      end
    end
  end
end

Middleman::Extensions.register(:oc_web_core, OC::Web::Core::Middleman)
