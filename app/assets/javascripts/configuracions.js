if (typeof AGan == "undefined") AGan = {};

AGan.add_configuracion_cambio_animals_fields = 
AGan.add_configuracion_cambio_edads_fields = 
AGan.add_configuracion_descartes_fields = 

function (link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  var $fields = $(content.replace(regexp, new_id));

  $fields.find("select").append( AGan.getOptions(ganado) );

  $fields.insertBefore($(link).parent().parent());
}

$(function () {
  $("select").append( AGan.getOptions(ganado) );

  $(document).on("click", ".delete_field", function () {
    $(this).parent().find("input.destroy_input").val("1");
    $(this).parents("tr").hide(300);

    return false;
  });
});