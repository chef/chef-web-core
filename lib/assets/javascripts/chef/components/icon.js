//= require ../chef

(function($, window) {
  'use strict';

  Chef.Web.Core.components.icon = {
    init: function() {

      var $icons = $('<div id="chef-icons"></div>');
      $('body').prepend($icons);

      $icons.load(Chef.Web.Core.imageUrl('icons/all.svg'));

      $('i[class^=icon_]').each(function() {
        var $el = $(this);
        var className = $el.attr('class').split(' ')[0];
        $el.append(
          $('<svg class="' + className + '"><use xlink:href="#' + className + '"></use></svg>')
        );
      });
    }
  };

})(jQuery, window);