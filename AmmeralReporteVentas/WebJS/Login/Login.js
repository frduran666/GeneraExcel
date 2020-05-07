$(document).ready(function () {
    $("#Login").click(function () {
        var nombre = $("#Nombre").val();
        var contrasena = $("#Contrasena").val();
        var urlIndex = $("#urlIndex").val();
        var urlParametros = $("#urlParametros").val();

        var urlLogin = $("#urlLogin").val();
        $.ajax({
            type: "POST",
            url: "Login",
            data: {
                _Nombre: nombre,
                _Contrasena: contrasena
            },
            async: true,
            success: function (data) {
                try {
                    if (data.Verificador !== undefined) {
                        if (!data.Verificador) {
                            $("#modalErrorLoginMensaje").html(data.Mensaje);
                            $("#aModalErrorLogin").click();
                            return;
                        }
                    }
                }
                catch (e) {

                }
                if (data.Validador == 1) {
                    window.location = "/Reporte/ReporteVentas";
                    //traer url de vista
                }
                if (data.Validador == 2) {
                    window.location = "/Reporte/ReporteVentas";
                    //traer url de vista
                }
                if (data.Validador == 3) {
                    $("#aModalEmpresas").click();

                    $("#ddlEmpresas").find('option').remove().end();

                    $.each(data.empresas, function (index, item) {
                        $("#ddlEmpresas").append('<option value="' + item.IdEmpresa + '">' + item.NombreEmpresa + '</option>');
                    });

                    $("#modalEmpresasAgregar").click(function () {
                        var empresa = $("#ddlEmpresas").val();

                        var urlSeleccionaEmpresa = $("#urlSeleccionaEmpresa").val();

                        $.ajax({
                            url: urlSeleccionaEmpresa,
                            type: "POST",
                            data: { _IdEmpresa: empresa },
                            async: true,
                            success: function (data) {
                                if (data.Validador = 1) {
                                    //alert("Empresa Seleccionada: " + data.NombreEmpresa);
                                    window.location = urlIndex;
                                }
                            }
                        });
                    });
                }
            },
            error: function (a, b, c) {
                console.log(a, b, c);

            }
        });
    });
});