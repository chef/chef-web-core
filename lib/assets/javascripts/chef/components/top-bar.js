//= require foundation

(function($, window) {
  'use strict';

  $(function() {

    // WIP: Just experimenting here.

    $('.top-bar').each(function() {
      var $el = $(this);
      var useGlobal = $el.data('global');

      if (useGlobal !== undefined) {
        var bar = $('<div class="top-bar-tab-content"><div class="content">Non-controversial inter-site navigation goes here.</div></div>');
        var btn = $('<button class="top-bar-tab"><i class="fi-list"></i></button>');

        btn.click(function() {
          bar.toggleClass('expanded');
        });

        $el.prepend(btn);
        $el.before(bar);
      }
    });
  });

})(jQuery, window);