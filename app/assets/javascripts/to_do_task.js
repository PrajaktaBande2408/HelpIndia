
var monthNames = ["January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
];
$(document).ready(function() {


    $(document).on("click", ".doneCheck", function() {
        // $(".doneCheck").click(function(){
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

    eachDoncheck();

    ////day view

    $('.oneDayBack').on("click", function () {
        getDayToDisplay("oneDayBack");
    });

    $('.oneDayFwd').on("click", function () {
        getDayToDisplay("oneDayFwd");
    });
    // getDayToDisplay("onLoad");



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

    $( function() {
        $( "#selectedDay" ).datepicker();
    } );

    //MonthView
    $('.oneMonthBack').on("click", function () {
        getMonthToDisplay("oneMonthBack");
    });

    $('.oneMonthFwd').on("click", function () {
        getMonthToDisplay("oneMonthFwd");
    });
    // getMonthToDisplay("onLoad");


});
    function eachDoncheck () {
    $( ".doneCheck" ).each(function() {
        if ($(this).val() == "on") {
            $(this).prop('checked', true);
            $(this).parent().next().addClass("doneItems");

        }
    });

    }

    function callAjax(dateTosend) {
        var selectedMonth = dateTosend
        var userId =$("#selectedMonth").attr('data-id');

        $.ajax({
            url: '/to_do_task/refreshMonthView',
            type: 'post',
            data: {'selectedMonth': selectedMonth,'user_id': userId },
            success: function( data ){
                $("#displayMonthtasks").html(" ").html(data);
                eachDoncheck();
            }
        });

    }

    function getMonthToDisplay(type){
        var myVariable = $('#selectedMonth').val();
        // var myVariable = "jan 2014"
        var makeDate = new Date(myVariable);
        if (type == "oneMonthBack"){
        makeDate = new Date(makeDate.setMonth(makeDate.getMonth() - 1));}
        else if(type == "oneMonthFwd"){
            makeDate = new Date(makeDate.setMonth(makeDate.getMonth() + 1));}
        else if(type == "onLoad"){
            makeDate = new Date(makeDate.setMonth(makeDate.getMonth() ));}


        var dateTosend = ('0' + (makeDate.getMonth()+1)).slice(-2).toString() +" "+ makeDate.getFullYear().toString();
        $('#selectedMonth').val(monthNames[makeDate.getMonth() ]+" "+ makeDate.getFullYear());
        callAjax(dateTosend);

    }

    function getDayToDisplay(type) {
        var myVariable = $('#selectedDay').val();
        // var myVariable = "jan 2014"
        var makeDate = new Date(myVariable);
        if (type == "oneDayBack"){
            makeDate = new Date(makeDate.setDate(makeDate.getDate() - 1));}
        else if(type == "oneDayFwd"){
            makeDate = new Date(makeDate.setDate(makeDate.getDate() + 1));}
        else if(type == "onLoad"){
            makeDate = new Date(makeDate.setDate(makeDate.getDate() ));}

        var dateToSend =(makeDate.getMonth() + 1) + "/" + makeDate.getDate() + "/" + makeDate.getFullYear()

        $('#selectedDay').val(dateToSend);

        var userId = $('#selectedDay').attr('data-id');
        $.ajax({
            url: '/to_do_task/refreshDayView',
            type: 'post',
            data: {'selectedDay' :dateToSend,'user_id' : userId },
            success: function( data ){
                $("#displayDailytasks").html(" ").html(data);
                eachDoncheck();

            }
        });
    }


