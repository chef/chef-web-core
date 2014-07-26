# oc-web-core

Shared resources for Chef web properties.

It's a set of [SCSS](http://sass-lang.com/) stylesheets and HTML templates that
can be imported into projects to get the global Chef styles.

The resources currently assume you are using and including
[Twitter Bootstrap 3](http://getbootstrap.com/). Things won't break if
you're not using this, but they won't look right.

## Installation

Add this line to your application's Gemfile:

    gem 'oc-web-core', git: 'git@github.com:opscode/oc-web-core'

It's currently a private repo, so you will need permissions to read it.

You'll want to use the latest master, and `bundle update oc-web-core` to apply
changes from this repository.

## Usage

### Stylesheets

Anything that uses [Sprockets](https://github.com/sstephenson/sprockets) should
be able to

```sass
@import 'oc';
```

in a Sass/SCSS stylesheet to get the included styles.

### Bootstrap

Our custom Bootstrap 3.2 is included in this repo in
[lib/assets/stylesheets/bootstrap.scss](lib/assets/stylesheets/bootstrap.scss).

The stylesheets do not include Bootstrap directly, but you can import it with

```css
@import 'bootstrap';
```

The Bootstrap JavaScript is not included, but you can use a CDN version:

```html
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js" type="text/javascript"></script>
```

Note that:

* The Bootstrap CSS is 3.2, but the JavaScript is 3.1.1. For some reason the 3.2
JavaScript causes the main mobile navigation to not work correctly.
* jQuery must be loaded for the Bootstrap JavaScript to work.

### Fonts

No fonts are included, but the
[Gotham fonts](http://www.typography.com/fonts/gotham/overview/) used can be
added by putting:

```html
<link href='//cloud.typography.com/6142912/687104/css/fonts.css' rel='stylesheet' type='text/css'>
```

in the document HEAD. These fonts are only licensed to work on Chef Software web
properties.

### Helpers

There are some helper methods:

* `oc_partial(partial_name)`: Reads a file from the templates directory. So, to
  use corpsite_footer.html: `oc_partial('corpsite_footer')`.
* `oc_title_tag`: Makes a title tag, with "| Chef appended.
  `oc_title_tag('Hello')` will output `<title>Hello | Chef</title>`. With no
  arguments you'll just get a title tag with "Chef" in it.

These are just methods in the
[OC::Web::Core::Helpers module](lib/oc/web/core/helpers.rb), which can
theoretically be used by any Ruby software. See below for specific framework
integrations.

### Framework Integrations

#### Middleman

In your config.rb, you should be able to include the following:

```ruby
require 'oc/web/core/helpers'
helpers do
  include OC::Web::Core::Helpers
end
```

This will let you use the `oc_partial` method in templates. You currently can
use:

```erb
<%= oc_partial :corpsite_header %>
<%= oc_partial :corpsite_footer %>
```

which do what you think they do.

#### Nanoc

To use the helpers in [Nanoc](http://nanoc.ws/), add

```ruby
require 'oc/web/core/helpers'
include OC::Web::Core::Helpers
```

to lib/helpers.rb (sometimes called lib/helpers_.rb), then the helper methods
will be available in your templates.

To use the stylesheets, add:

```ruby
require 'oc/web/core'
add_import_path OC::Web::Core::STYLESHEETS_PATH
```

to compass/config.rb.

## Tests

Run `bundle exec rspec` to run the RSpecs.
