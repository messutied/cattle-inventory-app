

var AGan = {};

(function($) {
    var deMeses = [1, 2];
    var NACIDOS = false;
    var LAST_SEL = null;
    var TYPE = ""
    

    $(document).ready(function() {
        TYPE = $("input[name=type]").val();

        $("td.perdida").popover({title: "Info. Pérdida de Ganado", delay: { show: 500, hide: 0 }});
        

        $("#movimiento_submit").click(function() {
            return validateSubmit();
        });

        // Cargar el predio sec. al seleccionar el primario
        // quitando el predio seleccionado en el primario
        $("#movimiento_predio_id").change(function() {
            var selected = $(this).val() * 1;
            var opts     = getOptions(predios, [selected]);

            $("#movimiento_predio_sec_id").html(opts);
        });

        // En un nuevo recuento, pre cargar todas las categorias de ganado
        if (TYPE == "rec") {
            if (window.location.pathname.indexOf("/new") != -1) {
                var categs = $('.movimiento:last select option').size();

                for (var i=0; i < categs; i++) {
                    $('.movimiento:last select option').eq(1).attr('selected', 'selected');
                    cleanSelect( $('.movimiento:last select') );
                    $("#add_mov").click();
                }
            }
            else {

            }
        }

        // On Edit: Poner todos los selects menos el ultimo como "read only"
        if (window.location.pathname.indexOf("/edit") != -1) {
            $('.movimiento select').each(function() {
                cleanSelect( $(this) );
            });
        }

        // Tomar en cuenta la razon de NACIDOS, solo permitir selecc. Terneros de meses
        $("#movimiento_movimientos_tipo_id").change(function() {
            if ($(this).val() == 2) {
                var hayMayoresDeMes = false;
                if (confirm("¿Desea ingresar Nacimientos?")) {
                    NACIDOS = true;
                    removeMayoresDeMes();
                }
                else {
                    $(this).val(LAST_SEL);
                }
            }
            else NACIDOS = false;

            if (LAST_SEL == 2) removeMayoresDeMes();

            LAST_SEL = $(this).val();
        })
    });
    
    // Quita todas las categorias de mas de un mes, del movimiento
    function removeMayoresDeMes() {
        $(".movimiento").remove();

        if ($(".movimiento").size() < 1) {
            addGanadoCateg();
        }
    }

    function getOptions(opts_arr, exclude, min) {
        var opts  = "";
        var count = 0;

        if (typeof(min) == "undefined") min = 0;

        for (var i = 0; i < opts_arr.length; i++) {
            var id = opts_arr[i][1];
            if (exclude.indexOf(id) == -1) {
                opts += "<option value='" + id + "'>" + opts_arr[i][0] + "</option>";
                count++;
            }
        }

        if (count <= min) return false;

        return opts;
    }

    // Quita todas las opciones de un select, menos la seleccionada (read only select)
    function cleanSelect($select) {
        var selected = $select.val();
        $select.find("option").each(function() {
            if (selected != $(this).val()) $(this).remove();
        });
    }

    function addGanadoCateg() {
        $("#add_mov").click();
    }

    // Cuando se da click en borrar una categ. de ganado de un movimienro/ingreso/egreso/recuento
    AGan.remove_fields = function(link) {
        $(link).prev("input[type=hidden]").val("1");
        var $row = $(link).parent().parent();

        if ($row.find("select").val() == "") {
            // Si no tiene nada seleccionado se elimina
            $row.remove();
        }
        else {
            $row.hide(); // Si no solo se esconde
        }
    }

    AGan.add_fields = function (link, association, content) {
        var used = [];
        var unselected = false;
        $('.movimiento select:visible').each(function() {
            used.push($(this).val() * 1);
            if ($(this).val() == "") unselected = true;
        });

        if (unselected && TYPE != "rec") {
            alert("Porfavor selecciona el ganado");
            return;
        }

        if (!NACIDOS)
            var opts = getOptions(ganado, used, 1);
        else
            var opts = getOptions(ganado_unmes, used, 1);

        if (opts === false) return;

        cleanSelect($('.movimiento:last select'));


        var new_id = new Date().getTime();
        var regexp = new RegExp("new_" + association, "g");
        var $fields = $(content.replace(regexp, new_id));
        $fields.insertBefore($(link).parent().parent());

        $fields.find("select").html(opts);

        // TODO: agregar las opciones del select
    }

    function validateSubmit() {
        if ($('.movimiento select[value!=]').size() < 1) {
            alert("Selecciona por lo menos una categoría de ganado");
            return false;
        }
        if ($('.movimiento select[value!=]').parents(".movimiento").find(".cant1[value=]").size() > 0) {
            alert("Has dejado un campo de Cantidad/Despachado sin llenar");
            return false;
        }

        return true;
    }

    })(jQuery);

    