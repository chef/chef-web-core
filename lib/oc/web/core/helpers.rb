require 'oc/web/core'
require 'chef/web/core'
require 'chef/web/core/component'

# Base module for oc-web-core to be used with other frameworks.
module OC
  module Web
    module Core
      module Helpers
        # Load a partial from templates/#{name}.html
        def oc_partial(name)
          Chef::Web::Core::Component.new(:type => name).render
        end

        # A title tag
        def oc_title_tag(text = nil)
          "<title>#{text}#{!text.nil? ? ' | ' : ''}Chef</title>"
        end
      end
    end
  end
end
