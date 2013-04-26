$(function () {
  // Open popup with empleado#new view
  $("#add_empleado").click(function(evt) {
      $.ajax({
          url: "/empleados/new",
          timeout: 5000,
          success: function(data) {
              $("#addEmpleadoModal .modal-body").html(data);
              $("#empleado_nombre").focus();
          },
          error: function(data){
              alert("Hubo un error por favor intente de nuevo");
          }
      });
  });

  // Creates new empleado through ajax
  $("#create_empleado_form").live("ajax:success", function(xhr, data, status) {
      var d = JSON.parse(data);

      if (d.error) {
          alert("Hubo un error guardando el empleado");
      }
      else {
          var emp = d.empleado;
          $(".empleado_selector").append("<option selected='selected' value='"+emp.id+"'>"+emp.nombre+"</option>");
          $('#addEmpleadoModal').modal('hide');
      }
  });
});