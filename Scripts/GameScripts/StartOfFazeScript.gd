extends ColorRect

var startOfStrategyFazeTimer : Timer

func _ready():
	startOfStrategyFazeTimer = get_tree().get_root().get_node("Game/Timers/StartOfStrategyFazeTimer")
	startOfStrategyFazeTimer.connect("timeout", self, "fazeStart")
		
func fazeStart():
	self.visible = false
	handleInputs(false)

func handleInputs(isActive):
	set_process(isActive)
	set_physics_process(isActive)
	set_process_unhandled_input(isActive)
	set_process_input(isActive)


func _on_Game_fightFazeEnded():
	self.visible = true
	handleInputs(false)
	startOfStrategyFazeTimer.start()
