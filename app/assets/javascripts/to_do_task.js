
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree

$(document).ready(function() {

    var monthNames = ["January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    ];
    // $(document).on("click", ".doneCheck", function() {
        $(".doneCheck").click(function(){
        var isDone="";
        var taskID= $(this).attr('name')
        if ($(this).is(':checked')) {
            $(this).parent().next().addClass("doneItems");
            isDone="on"
        }
        else{
            $(this).parent().next().removeClass("doneItems")
            isDone= " "

        }
        $.ajax({
            url: '/to_do_task/submitCheckboxVal',
            type: 'post',
            data: {'status' :isDone,'taskID' :taskID },
            success: function( data ){

            }
        });
    });

    $( ".doneCheck" ).each(function() {
        if ($(this).val() == "on") {
            $(this).prop('checked', true);
            $(this).parent().next().addClass("doneItems");

        }
    });

    ////day view
    $("#selectedDay").change(function() {
        var userId =$(this).attr('data-id');
        $.ajax({
            url: '/to_do_task/refreshDayView',
            type: 'post',
            data: {'selectedDay' :$(this).val(),'user_id' : userId },
            success: function( data ){
                $("#displayDailytasks").html(" ").html(data);
            }
        });
    });






    $('.oneDayBack').on("click", function () {

        var myVariable = $('#selectedMonth').val();
        // var myVariable = "jan 2014"
        var makeDate = new Date(myVariable);
        makeDate = new Date(makeDate.setMonth(makeDate.getMonth() - 1));
        var dateTosend = ('0' + (makeDate.getMonth()+1)).slice(-2).toString() +" "+ makeDate.getFullYear().toString();
        $('#selectedMonth').val(monthNames[makeDate.getMonth() ]+" "+ makeDate.getFullYear());
        callAjax(dateTosend);
    });
    $('.oneDayFwd').on("click", function () {

        var myVariable = $('#selectedMonth').val();
        // var myVariable = "jan 2014"
        var makeDate = new Date(myVariable);
        makeDate = new Date(makeDate.setMonth(makeDate.getMonth() + 1));
        var dateTosend = ('0' + (makeDate.getMonth()+1)).slice(-2).toString() +" "+ makeDate.getFullYear().toString();
        $('#selectedMonth').val(monthNames[makeDate.getMonth() ]+" "+ makeDate.getFullYear());
        callAjax(dateTosend);

    });

    function callAjax(dateTosend) {
        var selectedMonth = dateTosend
        var userId =$("#selectedMonth").attr('data-id');

        $.ajax({
            url: '/to_do_task/refreshMonthView',
            type: 'post',
            data: {'selectedMonth': selectedMonth,'user_id': userId },
            success: function( data ){
                $("#displayMonthtasks").html(" ").html(data);
            }
        });
    }

    $( function() {
        $("#selectedDay").datepicker();
    } );

});

