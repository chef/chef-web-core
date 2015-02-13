//= require foundation

(function($, window) {
  'use strict';

  Chef.Web.Core.components.logo = {
    init: function() {

      $('.logo').each(function() {
        var $el = $(this);
        
        $el.append(
          $('<object type="image/svg+xml"><img src="' + Chef.Web.Core.imageUrl('chef-logo.png') + '"></object>')
            .attr('data', Chef.Web.Core.imageUrl('chef-logo.svg') + '?site=' + escape($el.data('tagLine') || '') + '&theme=' + ($el.hasClass('inverse') ? 'inverse' : 'default'))
        );
      });
    }
  };

})(jQuery, window);