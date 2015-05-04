//= require ../chef

(function($, window) {
  'use strict';

  Chef.Web.Core.components.logo = {
    init: function() {

      $('.logo').each(function() {
        var $el = $(this);
        var settings = window.getComputedStyle($el.get(0), ':after').getPropertyValue('content').replace(/"/g, '').split('-');
        var theme = settings[0];
        var orientation = settings[1]
        
        $el.append(
          $('<object type="image/svg+xml"></object>')
            .attr('data', Chef.Web.Core.imageUrl('chef-logo.svg') 
              + '?orientation=' + orientation 
              + '&theme=' + theme 
              + '&site=' + escape($el.data('tagLine') || ''))
        );
      });
    }
  };

})(jQuery, window);