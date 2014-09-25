require 'erb'

module OC
  module Web
    module Core

      class Component
        attr_accessor :type, :name

        def initialize(opts={})
          opts.each do |k, v|
            instance_variable_set("@#{k}", v) unless v.nil?
          end
        end

        def render
          erb = ERB.new(open(File.join(OC::Web::Core::TEMPLATES_PATH, "#{type}.html.erb")).read)
          erb.result(get_binding)
        end

        private

          def get_binding
            binding
          end

      end
    end
  end
end