extends FreeCamera
class_name FreeCameraMaster

var agents : Array[TestAgent]
func _ready() -> void:
	for c in get_children():
		if c is TestAgent:
			agents.push_back(c)

func process_ai(id: int) -> void:
	var agent : TestAgent = agents[id]
	agent.calculate_route.call_deferred()



func _process(delta: float) -> void:
	super(delta)
	var task_id = WorkerThreadPool.add_group_task(process_ai, agents.size())
	WorkerThreadPool.wait_for_group_task_completion(task_id)
