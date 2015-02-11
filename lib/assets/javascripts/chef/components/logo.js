//= require foundation

(function($, window) {
  'use strict';

  // WIP: Just experimenting here.

  $('.logo').each(function() {
    var $el = $(this);
    $el.append(
      $('<object type="image/svg+xml"><img src="/assets/images/chef-logo.png"></object>')
        .attr('data', '/assets/images/chef-logo.svg?site=' + escape($el.data('tagLine') || '') + '&theme=' + ($el.hasClass('inverse') ? 'inverse' : 'default'))
    );
  });

})(jQuery, window);