$(document).ready(function () {
    $("#btnCrearReporte").click(function () {
        $("#divCreandoReporte").fadeOut();
        $("#divCreandoReporteCargando").fadeIn();
        $("#divCreandoReporteCreado").fadeOut();
        $("#divCreandoReporteError").fadeOut();

        var fechaDesde = fechaSeleccionada.fechaDesde.format("YYYY-MM-DD");
        var fechaHasta = fechaSeleccionada.fechaHasta.format("YYYY-MM-DD");

        if (fechaDesde !== "" && fechaHasta !== "") {
            $("#divCreandoReporte").fadeIn();
            $.ajax({
                type: "POST",
                url: "GenerarReporteVentas",
                data: {
                    fechaDesde: fechaDesde,
                    fechaHasta: fechaHasta
                },
                async: true,
                success: function (response) {
                    if (response.Verificador) {
                        $("#divCreandoReporteCargando").fadeOut("", function () {
                            $("#divCreandoReporteCreado").fadeIn();
                        });
                    }
                    else {
                        $("#divCreandoReporte").fadeOut("", function () {
                            $("#divCreandoReporteError").fadeIn();
                        });
                    }
                },
                error: function (a, b, c) {
                    $("#divCreandoReporteError").fadeIn();
                }
            });
        }
        else {
            abrirError("Ingreso Datos", "Favor debe ingresar todos los datos para continuar");
        }
    });
    $("#divCreandoReporteCreadoDescargar").click(function () {
        $("#divCreandoReporte").fadeOut();
        $("#divCreandoReporteCargando").fadeIn();
        $("#divCreandoReporteCreado").fadeOut();
        $("#divCreandoReporteError").fadeOut();
        window.open("DescargarArchivoVentas");
    });





    $('#rangoFecha span').html(fechaSeleccionada.fechaDesde.format('DD/MM/YYYY') + ' - ' + fechaSeleccionada.fechaHasta.format('DD/MM/YYYY'));

    $('#rangoFecha').daterangepicker({
        format: 'DD/MM/YYYY',
        startDate: moment().subtract(7, 'days'),
        endDate: moment(),
        minDate: '01/01/2012',
        //maxDate: '12/31/2015',
        dateLimit: { days: 60 },
        showDropdowns: true,
        showWeekNumbers: true,
        timePicker: false,
        timePickerIncrement: 1,
        timePicker12Hour: true,
        ranges: {
            'Hoy': [moment(), moment()],
            'Ayer': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            'Ultimos 7 Dias': [moment().subtract(6, 'days'), moment()],
            'Ultimos 30 Dias': [moment().subtract(29, 'days'), moment()],
            'Este Mes': [moment().startOf('month'), moment().endOf('month')],
            'Mes Anterior': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        },
        opens: 'right',
        drops: 'down',
        buttonClasses: ['btn', 'btn-sm'],
        applyClass: 'btn-primary',
        cancelClass: 'btn-default',
        separator: ' to ',
        locale: {
            applyLabel: 'Aceptar',
            cancelLabel: 'Cancelar',
            fromLabel: 'Desde',
            toLabel: 'a',
            customRangeLabel: 'Personalizado',
            daysOfWeek: ['Dom', 'Lun', 'Mar', 'Mie', 'Jue', 'Vie', 'Sab'],
            monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
            firstDay: 1
        }
    }, function (start, end, label) {
        fechaSeleccionada.fechaDesde = start;
        fechaSeleccionada.fechaHasta = end;
        $('#rangoFecha span').html(start.format('DD/MM/YYYY') + ' - ' + end.format('DD/MM/YYYY'));
    });
});

var fechaSeleccionada = {
    fechaDesde: moment().subtract('days', 7),
    fechaHasta: moment()
};