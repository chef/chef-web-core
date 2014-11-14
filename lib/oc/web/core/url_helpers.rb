require 'oc/web/core'

class Chef
  module Web
    module Core
      module URLHelpers

        class Site
          attr_accessor :subdomain, :domain

          def initialize(subdomain, domain=nil)
            @subdomain = subdomain
            @domain = domain || chef_domain
          end

          def hostname
            "#{subdomain}.#{domain}"
          end

          def non_secure_url
            "http://#{hostname}"
          end

          def secure_url
            "https://#{hostname}"
          end

          def canonical_url
            secure_url
          end

          def protocol_relative_url
            "//#{hostname}"
          end

          alias_method :url, :canonical_url
          alias_method :to_s, :canonical_url

          private

            def chef_domain
              ENV['CHEF_DOMAIN'] || 'getchef.com'
            end
        end

        def opscode_domain
          'opscode.com'
        end

        def corpsite
          @_corpsite ||= Site.new('www')
        end

        def chef_docs
          @_docs ||= Site.new('docs')
        end

        def chef_downloads
          @_downloads ||= Site.new('downloads')
        end

        def chef_manage
          @_manage ||= Site.new('manage', opscode_domain)
        end

        def learn_chef
          @_learn ||= Site.new('learn')
        end

        def supermarket
          @_supermarket ||= Site.new('supermarket')
        end

        def facebook_url 
          'https://www.facebook.com/getchefdotcom'
        end

        def twitter_url 
          'https://twitter.com/chef'
        end

        def youtube_url 
          'http://www.youtube.com/user/getchef'
        end

        def linkedin_url 
          'https://www.linkedin.com/groups/Chef-Users-Group-3751378'
        end

      end
    end
  end
end
