//= require twitter/bootstrap
//= require jquery
//= require jquery_ujs
//= require_self
//= require_directory .


// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

(function($) {

    function menuHide() {
        $(".span2").hide();
        $("#hide-menu i").removeClass("icon-minus-sign").addClass("icon-plus-sign");
        $("#hide-menu span").html("Mostrar Menú");
        $(".span10").css("margin-left", "0");
        $(".span10").removeClass("span10").addClass("span12");
    }

    function menuShow() {
        $(".span2").show();
        $("#hide-menu i").removeClass("icon-plus-sign").addClass("icon-minus-sign");
        $("#hide-menu span").html("Esconder Menú");
        $(".span12").removeClass("span12").addClass("span10");
        $(".span10").css("margin-left", "30px");
    }

    $(document).ready(function() {
        
        if ($.cookie("menu_state") != null) {
            if ($.cookie("menu_state") == "hide") {
                menuHide();
            }
        }

        // Hide/Show Menu
        $("#hide-menu").click(function() {
            if ($(".span2").is(":visible")) { // HIDE THE MENU
                $(".span2").hide();
                $("#hide-menu i").removeClass("icon-minus-sign").addClass("icon-plus-sign");
                $("#hide-menu span").html("Mostrar Menú");
                $(".span10").css("margin-left", "0");
                $(".span10").removeClass("span10").addClass("span12");

                $.cookie("menu_state", "hide");
            }
            else { // SHOW THE MENU
                $(".span2").show();
                $("#hide-menu i").removeClass("icon-plus-sign").addClass("icon-minus-sign");
                $("#hide-menu span").html("Esconder Menú");
                $(".span12").removeClass("span12").addClass("span10");
                $(".span10").css("margin-left", "30px");

                $.cookie("menu_state", "show");
            }
        });
    });
})(jQuery)