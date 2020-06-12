extends Node

export (PackedScene) var soldierModel

var soldiersContainer : Node

func _ready():	
	pass

func spawnSoldier(position, positionToMoveTowards, uid):
	var soldier : KinematicBody2D = soldierModel.instance()
	soldier.set_script(load("res://Scripts/GameScripts/Enemy/EnemySoldierScript.gd"))
	soldier.uid = uid
	self.add_child(soldier)
	soldier.position = position
	soldier.positionToMoveTowards = positionToMoveTowards
	get_node("EnemyController").enemySoldiers.append(soldier)
	
func _on_Game_fightFateStartingSignal():
	for soldier in get_node("EnemyController").enemySoldiers:
		soldier.isFightFaze = true

func _on_EnemyLanes_enemySpawnedSoldierSignal(position, positionToMoveTowards, counterOfSoldiersAlreadyInLane, uid):
	position.y += 30 * counterOfSoldiersAlreadyInLane
	spawnSoldier(position, positionToMoveTowards, uid)
