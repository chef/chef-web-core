# oc-web-core

Shared resources for Chef web properties.

It's a set of [SCSS](http://sass-lang.com/) stylesheets and HTML templates that
can be imported into projects to get the global Chef styles.

The resources currently assume you are using and including
[Twitter Bootstrap 2.3.2](http://getbootstrap.com/2.3.2/). Things won't break if
you're not using this, but they won't look right.

## Installation

Add this line to your application's Gemfile:

    gem 'oc-web-core', git: 'git@github.com:opscode/oc-web-core'

It's currently a private repo, so you will need permissions to read it.

## Usage

### Middleman

A [Middleman](http://middlemanapp.com/) extension is included. In your
config.rb, you should be able to include the following:

```ruby
require 'oc/web/core/middleman'
activate :oc_web_core
```

This will let you use the `oc_partial` method in templates. You currently can
use:

```erb
<%= oc_partial :corpsite_header %>
<%= oc_partial :corpsite_footer %>
```

which do what you think they do.



### Stylesheets

Anything that uses [Sprockets](https://github.com/sstephenson/sprockets) should
be able to

```sass
@import 'oc';
```

in a Sass/SCSS stylesheet to get the included styles.

