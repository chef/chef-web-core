//= require ../chef

(function($, window) {
  'use strict';

  Chef.Web.Core.components.logo = {
    init: function() {

      $('.logo').each(function() {
        var $el = $(this);
        
        if ($el.find('> svg').length === 0) {
          $el.load(Chef.Web.Core.imageUrl('chef-logo.svg'), function() {
            var tag = $el.data('tag-line');
            if (tag) {
              this.querySelector('svg .tag-line text').textContent = tag;
            }
          });  
        }
      });
    },

    refresh: function() {
      $('.logo svg').remove();
      this.init();
    }
  };

})(jQuery, window);