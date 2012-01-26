(function($) {

    var deMeses = [1, 2];
    var NACIDOS = false;

    $(document).ready(function() {
        $("#movimiento_predio_id").change(function() {
            var selected = $(this).val() * 1;
            var opts     = getOptions(predios, [selected]);

            $("#movimiento_predio_sec_id").html(opts);
        });

        $("#addMov").live("click", function() {
            addGanadoCateg();
        });

        // addGanadoCateg();

        $("#movimiento_movimientos_tipo_id").change(function() {
            if ($(this).val() == 2) {
                var hayMayoresDeMes = false;
                if (confirm("¿Desea ingresar Nacimientos?")) {
                    NACIDOS = true;
                    removeMayoresDeMes();
                }
            }
            else NACIDOS = false;
        })
    });

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

    function cleanSelect($select) {
        var selected = $select.val();
        $select.find("option").each(function() {
            if (selected != $(this).val()) $(this).remove();
        });
    }

    function addGanadoCateg() {
        var used = [];
        var unselected = false;
        $('.movimiento select').each(function() {
            used.push($(this).val() * 1);
            if ($(this).val() == "") unselected = true;
        });

        if (unselected) {
            alert("Porfavor selecciona el ganado");
            return;
        }
        if (!NACIDOS)
        var opts = getOptions(ganado, used, 1);
        else
        var opts = getOptions(ganado_unmes, used, 1);

        if (opts === false) return;

        if (TIPO == "mov") {
            var input = 'Despach: <input class="small" type="text" name="despach[]" /> ' +
            'Rcp: <input class="small" type="text" name="rcp[]" /> ';
        }
        else {
            var input = 'Cant: <input class="small" type="text" name="cant[]" /> ';
        }

        var mov = '<div class="movimiento">' +
        '<select name="ganado[]" style="width: 250px">' + opts + '</select>' +
        '<div class="r_data" style="float: right">' +
        input +
        '<div style="clear:both"></div></div>' +
        '<div style="clear:both"></div></div';

        cleanSelect($('.movimiento:last select'));
        $('#movimientos').append(mov);

        $("#addMov").remove();
        $(".movimiento:last div.r_data").append("<input style='float: right;' id='addMov' type='button' value='+' />");
    }

    })(jQuery);

    function add_fields(link, association, content) {
        var new_id = new Date().getTime();
        var regexp = new RegExp("new_" + association, "g");
        jQuery(link).parent().before(content.replace(regexp, new_id));
        // TODO: agregar las opciones del select
    }