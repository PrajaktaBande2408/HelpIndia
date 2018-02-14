
var monthNames = ["January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
];
// $(document).ready(function() {
    $(document).on('turbolinks:load', function() {

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
});

    function eachDoncheck () {
    $( ".doneCheck" ).each(function() {
        if ($(this).val() == "on") {
            $(this).prop('checked', true);
            $(this).parent().next().addClass("doneItems");

        }
    });

    }








