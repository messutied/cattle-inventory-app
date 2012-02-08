

var AGan = {};

(function($) {
    var deMeses = [1, 2];
    var NACIDOS = false;
    var LAST_SEL = null;
    

    $(document).ready(function() {
        $("#movimiento_predio_id").change(function() {
            var selected = $(this).val() * 1;
            var opts     = getOptions(predios, [selected]);

            $("#movimiento_predio_sec_id").html(opts);
        });

        // addGanadoCateg();

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
        $("#add_mov").click();
    }

    AGan.add_fields = function (link, association, content) {
        var used = [];
        var unselected = false;
        $j('.movimiento select').each(function() {
            used.push($j(this).val() * 1);
            if ($j(this).val() == "") unselected = true;
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

        cleanSelect($('.movimiento:last select'));


        var new_id = new Date().getTime();
        var regexp = new RegExp("new_" + association, "g");
        var $fields = $j(content.replace(regexp, new_id));
        $fields.insertBefore($j(link).parent());

        $fields.find("select").html(opts);

        // TODO: agregar las opciones del select
    }

    })(jQuery);

    