// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require_tree .
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require moment
//= require bootstrap-datetimepicker
//= require pickers
//= require moment/pt-br.js
//= require owl.carousel

$(document).ready(function() {
  $.material.init();
      var carousel = $("#owl-new-images");
      carousel.owlCarousel({
        slideSpeed : 50,
        paginationSpeed : 400,
        items : 1,
        autoPlay : true,
        itemsDesktop : false,
        itemsDesktopSmall : false,
        itemsTablet: false,
        itemsMobile : false,
        navigation:true,
        navigationText: [
          "<i class='icon-chevron-left icon-white'><</i>",
          "<i class='icon-chevron-right icon-white'>></i>"
        ],
    });
});