class Dayview extends React.Component {

    constructor(props)
    {
        super(props);
        var today = new Date(),
            date = (today.getMonth() + 1)+'/'+today.getDate()+'/'+today.getFullYear() ;
        this.state = {
            selectedDate: date,
        }

    }
    componentDidMount()
    {
        $("#selectedDay" ).datepicker();
        $('.oneDayBack').on("click", function () {
            getDayToDisplay("oneDayBack");
        });

        $('.oneDayFwd').on("click", function () {
            getDayToDisplay("oneDayFwd");
        });
        getDayToDisplay("onLoad");

        $("#selectedDay").change(function() {
            getDayToDisplay("onLoad");
        });

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

            var userId = $('#selectedDay').attr('dataid');
            $.ajax({
                url: '/to_do_task/refreshDayView.json',
                type: 'post',
                data: {'selectedDay' :dateToSend,'user_id' : userId , methodused:"ajax"},
                success: function( data ){
                    $("#displayDailytasks").html(" ").html(data);
                    eachDoncheck();

                }
            });
        }
    }
    render(){
        return(
            <div>
                <div style={{margin:"0 32%"}}>
                    <span > <img src='/assets/next.png'  className="oneDayBack"/></span>
                    <span><input className="selectedDay" type="text" id="selectedDay" value={this.state.selectedDate} dataid={this.props.userid} /></span>
                    <span> <img src='/assets/next.png'  className="oneDayFwd" /></span>
                </div>

                <div id="displayDailytasks" >
                </div>
            </div>

    )
    }
}