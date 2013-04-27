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
});