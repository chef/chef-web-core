# Chef Web Core

[![Build Status](https://magnum.travis-ci.com/chef/chef-web-core.svg?token=nLJzarE6qzx4H4HiqzJu&branch=master)](https://magnum.travis-ci.com/chef/chef-web-core)

A shared set of CSS ([Sass](http://sass-lang.com)), JavaScript and Ruby resources 
for Chef web properties, all bundled into a living style guide published at 
[style.chef.io](https://style.chef.io).

## Installing

### Ruby

If you're running in a Ruby environment with Bundler and [Sprockets](https://github.com/sstephenson/sprockets) 
(e.g., [Middleman](https://middlemanapp.com/), [Rails](http://rubyonrails.org/)), add 
the following line to your `Gemfile` (the repo is currently private, so you'll need 
permissions to read it):

    gem 'chef-web-core', git: 'git@github.com:chef/chef-web-core'

Then `bundle` to install. Once you've done that, you'll be able to include and use 
the Sass and JavaScript components [detailed in the style guide](https://style.chef.io/guide). 
For example, to include all of our CSS components in your app, add the following line to your 
main `.scss` file:

    @import 'chef';

Several components require JavaScript as well, so you'll want to include those modules 
also (e.g., in your main `.js`): 

    //= require chef

Alternatively, you can include only those components you want:

    @import 'chef/components/top-bar';
    @import 'chef/components/side-nav';
 
...along with their individual JavaScript counterparts:

    //= require chef/components/top-bar
    //= require chef/components/side-nav
 
Once you've imported some assets, you should be able to start putting markup into your pages and 
have their styles and behaviors appear automatically. If you're using any JavaScript components, 
be sure to initialize them at the end of your document &mdash; usually just before your closing 
`body` tag:
    
        ...
        <script>
          $(document).chef();
        </script>
      </body>
    </html>

There's a Rails application located at `spec/dummy/rails` (which we use for testing) 
that provides a working example you might like to refer to. You can run that locally by:

    cd spec/dummy/rails
    bundle
    bin/rails s

This repo is also a Middleman app, so it can be used as a reference as well:

    bundle
    bin/rake server

### Node.js

We're still working on first-class support for Node, but for now, you should be able to add 
a Git reference to your `package.json`:

    {
      ...
      "dependencies": {
        "chef-web-core": "git+ssh://git@github.com/chef/chef-web-core.git"
      }
      ...
    }

... and then `npm install` to pull the Sass and JavaScript assets into your app. 

## Updating

To get the latest updates, either:

    bundle update chef-web-core

or 

    npm update chef-web-core

## Contributing

This repository serves two purposes: it's both a collection of CSS and JavaScript components
and an automatically generated style guide for using them. The guide is built using 
[Middleman](https://middlemanapp.com/), a static Web site generator, and [Hologram](https://github.com/trulia/hologram), 
a documentation parser that turns formatted CSS comments into the HTML pages you see at 
[style.chef.io](https://style.chef.io).

To see how things things work, take a look at the `.scss` and `.js` files in `lib/assets`, then 
try running the Middleman app yourself. Assuming you have Ruby 2+, Git and the appropriate Github 
permissions, you should be able to:

    git clone git@github.com:chef/chef-web-core.git
    cd chef-web-core
    bundle
    bin/rake server

This starts a Middleman server at http://localhost:4567; open that address in your browser
and look around. Review the Middleman and Hologram docs to see how they work. When you
have something you'd like to contribute, [issue a pull request](pulls) to have your contribution
reviewed, incorporated and published!

If you'd like to contribute something other than code &mdash; feedback, a bug report or 
a suggestion or a new feature &mdash; [use Github issues](issues).

## Running the Tests

    bin/rake

See the `Rakefile` for additional options.