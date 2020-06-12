extends Node

var outerLeftLane : Control;
var innerLeftLane : Control;
var middleLane : Control;
var innerRightLane : Control;
var outerRightLane : Control;

var outerLeftContestPoint : Node2D
var innerLeftContestPoint : Node2D
var innerRightContestPoint : Node2D
var outerRightContestPoint : Node2D

var outerLeftLaneSoldierCounter = 0
var innerLeftLaneSoldierCounter = 0
var middleLaneSoldierCounter = 0
var innerRightLaneSoldierCounter = 0
var outerRightLaneSoldierCounter = 0

var enemyTower

signal enemySpawnedSoldierSignal(position, positionToMoveTowards, counterOfSoldiersAlreadyInLane)

func _ready():
	outerLeftLane = get_node("OuterLeftLane")
	innerLeftLane = get_node("InnerLeftLane")
	middleLane = get_node("MiddleLane")
	innerRightLane = get_node("InnerRightLane")
	outerRightLane = get_node("OuterRightLane")
	
	outerLeftContestPoint = get_tree().get_root().get_node("Game/Lanes/ContestPoints/OuterLeftContestPoint")
	innerLeftContestPoint = get_tree().get_root().get_node("Game/Lanes/ContestPoints/InnerLeftContestPoint")
	innerRightContestPoint = get_tree().get_root().get_node("Game/Lanes/ContestPoints/InnerRightContestPoint")
	outerRightContestPoint  = get_tree().get_root().get_node("Game/Lanes/ContestPoints/OuterRightContestPoint")
	
	enemyTower = get_tree().get_root().get_node("Game/MyTower")

func _on_Lanes_tellEnemySoldierSpawnedSignal(laneName, uid):
	rpc("addSoldierToArray", laneName, uid)

remote func addSoldierToArray(laneName, uid):
	if laneName == outerLeftLane.name:
		emit_signal("enemySpawnedSoldierSignal", getSpawnPointForSoldier(outerLeftLane), outerLeftContestPoint.position, outerLeftLaneSoldierCounter, uid)
		outerLeftLaneSoldierCounter += 1
		
	elif laneName == innerLeftLane.name:
		emit_signal("enemySpawnedSoldierSignal", getSpawnPointForSoldier(innerLeftLane), innerLeftContestPoint.position, innerLeftLaneSoldierCounter, uid)
		innerLeftLaneSoldierCounter += 1
		
	elif laneName == middleLane.name:
		emit_signal("enemySpawnedSoldierSignal", getSpawnPointForSoldier(middleLane), enemyTower.global_position, middleLaneSoldierCounter, uid)
		middleLaneSoldierCounter += 1
		
	elif laneName == innerRightLane.name:
		emit_signal("enemySpawnedSoldierSignal", getSpawnPointForSoldier(innerRightLane), innerRightContestPoint.position, innerRightLaneSoldierCounter, uid)
		innerRightLaneSoldierCounter += 1
		
	elif laneName == outerRightLane.name:
		emit_signal("enemySpawnedSoldierSignal", getSpawnPointForSoldier(outerRightLane), outerRightContestPoint.position, outerRightLaneSoldierCounter, uid)
		outerRightLaneSoldierCounter += 1

func getSpawnPointForSoldier(lane : Control):
	var x = lane.rect_size.x/2
	var y = lane.rect_size.y * 0.1
	var spawnPoint = lane.rect_position + Vector2(x, y)
	return spawnPoint


func _on_Game_fightFazeEnded():
	outerLeftLaneSoldierCounter = 0
	innerLeftLaneSoldierCounter = 0
	middleLaneSoldierCounter = 0
	innerRightLaneSoldierCounter = 0
	outerRightLaneSoldierCounter = 0
