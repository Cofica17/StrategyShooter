extends Node


func _ready():
	pass # Replace with function body.

func doArtillerySpellCasted(var laneName):
	rpc("artillerySpellCasted", laneName)

remote func artillerySpellCasted(laneName):
	var lane = get_tree().get_root().get_node("Game/Lanes/" + laneName)
	lane.artillerySpellCastedByEnemy()

func doMineSpellCasted(laneName):
	rpc("mineSpellCasted", laneName)
	
remote func mineSpellCasted(laneName):
	var lane = get_tree().get_root().get_node("Game/Lanes/" + laneName)
	lane.mineSpellCastedByEnemy()
	
func doMovementSpeedUpSpellCasted(laneName):
	rpc("movementSpeedUpSpellCasted", laneName)

remote func movementSpeedUpSpellCasted(laneName):
	var lane = get_tree().get_root().get_node("Game/EverythingEnemy/EnemyLanes/" + laneName)
	lane.movementSpeedUpSpellCastedByEnemy()
