extends Node

export (PackedScene) var soldierModel

var soldiersContainer : Node

func _ready():	
	pass

func spawnSoldier(position, positionToMoveTowards, uid):
	var soldier : KinematicBody2D = soldierModel.instance()
	soldier.uid = uid
	self.add_child(soldier)
	soldier.position = position
	soldier.positionToMoveTowards = positionToMoveTowards
	get_tree().get_root().get_node("Game/EverythingEnemy/Containers/EnemySoldierContainer/EnemyController").mySoldiers.append(soldier)

func _on_Lanes_spawnSoldier(position, positionToMoveTowards, counterOfSoldierAlreadyInLane, uid):
	position.y -= 30 * counterOfSoldierAlreadyInLane
	spawnSoldier(position, positionToMoveTowards, uid)
	
func _on_Game_fightFateStartingSignal():
	for soldier in get_tree().get_root().get_node("Game/EverythingEnemy/Containers/EnemySoldierContainer/EnemyController").mySoldiers:
		soldier.isFightFaze = true
