class Alltodotask extends React.Component{

    handleDelete(id,userid) {
        this.props.handleDelete(id,userid);
    }


    render() {

        var allTasks = this.props.allTasks.map((task) => {
            return (
                <div key={task.id}>
                    <div className="taskDisplay">
                        <span style={{width:"5%"}}> <input  id={task.id} name={task.id} type="checkbox" value={task.status} className="doneCheck" /></span>
                        <span style={{width:"40%"}}>{task.taskToDO}</span>

                        <span style={{width:"30%"}}>{task.date}</span>

            <span style={{width:"5%"}}><a href='#' onClick={this.handleDelete.bind(this, task.id,task.user_id)} user_id={task.user_id} id={task.id}><img src='/assets/delete.png'/></a></span>
                    </div>
                </div>
            )
        });

        return(
            <div>
                {allTasks}
            </div>
        )
    }
}
