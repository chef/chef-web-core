# Chef Web Core

[![Build Status](https://travis-ci.org/chef/chef-web-core.svg)](https://travis-ci.org/chef/chef-web-core)

A shared set of CSS ([Sass](http://sass-lang.com)), JavaScript and Ruby resources 
for Chef web properties, all bundled into a living style guide published at 
[style.chef.io](https://style.chef.io).

## Installing

### Ruby

If you're running in a Ruby environment with Bundler and [Sprockets](https://github.com/sstephenson/sprockets) 
(e.g., [Middleman](https://middlemanapp.com/), [Rails](http://rubyonrails.org/)), add 
the following line to your `Gemfile` to install from the `master` branch:

    gem "chef-web-core", :git => "https://github.com/chef/chef-web-core.git"

To install a particular version, specify it by tag:

    gem "chef-web-core", git: "https://github.com/chef/chef-web-core.git", tag: "0.1.8"

Then `bundle` to install. Once you've done that, you'll be able to include and use 
the Sass and JavaScript components [detailed in the style guide](https://style.chef.io/guide)
in your app. For example, to include all of our CSS components, add the following 
line to your main `.scss` file:

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

We deploy our builds to Github Releases, so you can install our Node.js package directly from 
there. Just specify the version you'd like to install in your `package.json`:

    {
      ...
      "dependencies": {
        "chef-web-core": "https://github.com/chef/chef-web-core/releases/download/0.0.1/chef-web-core-0.0.1.tgz"
      }
      ...
    }

... and then `npm install`. That'll get you a module with a `dist` directory containing all 
of the fonts, images, Sass and compiled JavaScript &amp; CSS comprising the guide for 
use in your app.

### CDN

If neither of these options works for you, you can always just load the assets over the network, 
via Cloudfront:
    
    <!DOCTYPE html>
    <html>
      <head>
        ...
        <link rel="stylesheet" href="//style.chef.io/dist/0.0.1/stylesheets/chef.css">
        <script src="//style.chef.io/dist/0.0.1/javascripts/chef.js">
        ...

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

## Releasing

We use Rake to tag our releases, which we deploy automatically with Travis to S3 and Github. 
When you're ready to tag a release, first determine whether it constitutes a `major`, `minor` or 
`patch` revision, then with a clean working tree, on the `master` branch, run the Rake task 
accordingly:

    bin/rake version:bump[patch]

This'll update the appropriate files, commit and tag the release for you, but it won't push it 
to Github. You can do that yourself when you're ready:
    
    git push origin master
    git push origin --tags 

When the tests pass, Travis will run the `publish` task, which will deploy the style-guide site to 
[style.chef.io](https://style.chef.io), compiled assets to style.chef.io/dist, and a gzipped 
archive to Github Releases.

## Running the Tests

    bin/rake

See the `Rakefile` for additional options.
