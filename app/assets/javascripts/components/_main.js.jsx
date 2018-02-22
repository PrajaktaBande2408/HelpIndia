
class Main extends React.Component{

    constructor(props)
    {
        super(props);
        this.state = {
            allTasks: [],
        }

    }

    componentDidMount()
    {
        var userid=this.props.userid;
        $.getJSON('/users/'+userid+'/to_do_task.json', (response) => { this.setState({ allTasks: response })
        });
    }

    handleDelete(id,userid) {
        $.ajax({
            url:  '/users/'+userid+'/to_do_task/'+id,
            type: 'DELETE',
            data:{methodused: "ajax"},
            success:() => { this.removeItemClient(id);
            }
        });
        }

    removeItemClient(id) {
        var newallTasks = this.state.allTasks.filter((task) => {
            return task.id != id;
        });
        this.setState(
            { allTasks: newallTasks,dayViewTasks : newallTasks}
            );
    }


    render() {
        var pstyle={
            color: "white",
            fontWeight: "bold",
            textAlign: "center"
        }

        return (
            <div>
                <div className="showAllToDoTask" >
                    <p style={pstyle}>All TODO Tasks</p>
                    <Alltodotask allTasks={this.state.allTasks}  handleDelete={this.handleDelete}/>
                </div>

                <div className="showAllToDoTask" >
                    <p style={pstyle}>TODO Day View</p>
                    <Dayview userid={this.props.userid}/>
                </div>

                <div className="showAllToDoTask" >
                    <p style={pstyle}>TODO Month View</p>
                    <Viewmonth userid={this.props.userid}/>
                </div>


            </div>
        )
    }
}


