require 'oc/web/core'

class Chef
  module Web
    module Core
      module URLHelpers
        
        def chef_domain
          ENV['CHEF_DOMAIN'] || 'getchef.com'
        end

        def that_other_chef_domain
          'opscode.com'
        end

        def corpsite_host
          "www.#{chef_domain}"
        end

        def docs_host
          "docs.#{chef_domain}"
        end

        def learn_chef_host
          "learn.#{chef_domain}"
        end

        def manage_host
          "manage.#{that_other_chef_domain}"
        end

        def supermarket_host
          "supermarket.#{chef_domain}"
        end

        def corpsite_url
          canonical_url_for(corpsite_host)
        end

        def docs_url
          canonical_url_for(docs_host)
        end

        def learn_chef_url
          canonical_url_for(learn_chef_host)
        end

        def manage_url
          secure_absolute_url_for(manage_host)
        end 

        def supermarket_url
          canonical_url_for(supermarket_host)
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

        def absolute_url_for(host)
          "http://#{host}"
        end

        def secure_absolute_url_for(host)
          "https://#{host}"
        end

        def protocol_relative_url_for(host)
          "//#{host}"
        end

        def canonical_url_for(host)
          secure_absolute_url_for(host)
        end

      end
    end
  end
end
