class Viewmonth extends React.Component {

    constructor(props)
    {
        super(props);
        var today = new Date(),
            date = monthNames[today.getMonth()] +" "+today.getFullYear();
        this.state = {
            selectedMonth: date,
        }

    }
    componentDidMount()
    {
        $('.oneMonthBack').on("click", function () {
            getMonthToDisplay("oneMonthBack");
        });

        $('.oneMonthFwd').on("click", function () {
            getMonthToDisplay("oneMonthFwd");
        });
        getMonthToDisplay("onLoad");

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

        function callAjax(dateTosend) {
            var selectedMonth = dateTosend
            var userId =$("#selectedMonth").attr('dataid');

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
    }
    render(){
        return(
            <div>
                <div style={{margin:"0 32%"}}>
                    <span > <img src='/assets/next.png'  className="oneMonthBack"/></span>
                    <span><input className="selectedMonth" type="text" id="selectedMonth" value={this.state.selectedMonth} dataid={this.props.userid} /></span>
                    <span> <img src='/assets/next.png'  className="oneMonthFwd" /></span>
                </div>

                <div id="displayMonthtasks" >
                </div>
            </div>

        )
    }
}