
(function($) {

    function menuHide() {
        $(".span3").hide();
        $("#hide-menu i").removeClass("icon-minus-sign").addClass("icon-plus-sign");
        $("#hide-menu span").html("Mostrar Menú");
        $(".span9").css("margin-left", "0");
        $(".span9").removeClass("span9").addClass("span12");
    }

    function menuShow() {
        $(".span3").show();
        $("#hide-menu i").removeClass("icon-plus-sign").addClass("icon-minus-sign");
        $("#hide-menu span").html("Esconder Menú");
        $(".span12").removeClass("span12").addClass("span9");
        $(".span9").css("margin-left", "30px");
    }

    $(document).ready(function() {
        
        if ($.cookie("menu_state") != null) {
            if ($.cookie("menu_state") == "hide") {
                menuHide();
            }
        }

        // Hide/Show Menu
        $("#hide-menu").click(function() {
            if ($(".span3").is(":visible")) { // HIDE THE MENU
                $(".span3").hide();
                $("#hide-menu i").removeClass("icon-minus-sign").addClass("icon-plus-sign");
                $("#hide-menu span").html("Mostrar Menú");
                $(".span9").css("margin-left", "0");
                $(".span9").removeClass("span9").addClass("span12");

                $.cookie("menu_state", "hide");
            }
            else { // SHOW THE MENU
                $(".span3").show();
                $("#hide-menu i").removeClass("icon-plus-sign").addClass("icon-minus-sign");
                $("#hide-menu span").html("Esconder Menú");
                $(".span12").removeClass("span12").addClass("span9");
                $(".span9").css("margin-left", "30px");

                $.cookie("menu_state", "show");
            }
        });
    });
})(jQuery)