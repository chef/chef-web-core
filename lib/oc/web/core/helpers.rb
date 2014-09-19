require 'oc/web/core'
require 'oc/web/core/component'

# Base module for oc-web-core to be used with other frameworks.
module OC
  module Web
    module Core
      module Helpers

        def oc_partial(name)
          open(File.join(OC::Web::Core::TEMPLATES_PATH, "#{name}.html")).read
        end

        def oc_title_tag(text = nil)
          "<title>#{text}#{!text.nil? ? ' | ' : ''}Chef</title>"
        end

        def oc_top_nav(site)
          OC::Web::Core::Component.new(sites[site].merge(type: :top_nav)).render
        end

        private 

        # Be nice now, this is just a WIP
        def sites
          {
            corpsite: {
              name: 'CHEF'
            },
            downloads: {
              name: 'Chef Downloads'
            },
            learnchef: {
              name: 'Learn Chef'
            },
            analytics: {
              name: 'Chef Analytics'
            },
            manage: {
              name: 'Chef Manage'
            },
            style: {
              name: 'CHEF Style'
            }
          }
        end
      end
    end
  end
end
