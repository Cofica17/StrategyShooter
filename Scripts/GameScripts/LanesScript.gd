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

var enemyTower : KinematicBody2D

var outerLeftLaneSoldierCounter = 0
var innerLeftLaneSoldierCounter = 0
var middleLaneSoldierCounter = 0
var innerRightLaneSoldierCounter = 0
var outerRightLaneSoldierCounter = 0

signal spawnSoldier(position, positionToMoveTowards, counterOfSoldiersAlreadyInLane)
signal tellEnemySoldierSpawnedSignal(laneName)

var spawningSoldiersIsOn = true
var spawningTanksIsOn = false

export var maxManpowerPerLane : int
var zeroManpowerReached = false

var isFightFaze = false

var UID : Script = preload("res://Scripts/GameScripts/Uid.gd")

func _ready():
	outerLeftLane = get_node("OuterLeftLane")
	innerLeftLane = get_node("InnerLeftLane")
	middleLane = get_node("MiddleLane")
	innerRightLane = get_node("InnerRightLane")
	outerRightLane = get_node("OuterRightLane")
	
	outerLeftContestPoint = get_node("ContestPoints/OuterLeftContestPoint")
	innerLeftContestPoint = get_node("ContestPoints/InnerLeftContestPoint")
	innerRightContestPoint = get_node("ContestPoints/InnerRightContestPoint")
	outerRightContestPoint  = get_node("ContestPoints/OuterRightContestPoint")
	
	enemyTower = get_tree().get_root().get_node("Game/EverythingEnemy/EnemyTower")
	
func _on_OuterLeftLane_gui_input(event):
	if isClicked(event) and outerLeftLaneSoldierCounter < maxManpowerPerLane and !zeroManpowerReached and !isFightFaze:
		spawnSomething(outerLeftLane, outerLeftContestPoint.position, outerLeftLaneSoldierCounter)
		outerLeftLaneSoldierCounter += 1

func _on_InnerLeftLane_gui_input(event):
	if isClicked(event) and innerLeftLaneSoldierCounter < maxManpowerPerLane and !zeroManpowerReached and !isFightFaze:
		spawnSomething(innerLeftLane, innerLeftContestPoint.position, innerLeftLaneSoldierCounter)
		innerLeftLaneSoldierCounter += 1

func _on_MiddleLane_gui_input(event):
	if isClicked(event) and middleLaneSoldierCounter < maxManpowerPerLane and !zeroManpowerReached and !isFightFaze:
		spawnSomething(middleLane, enemyTower.global_position, middleLaneSoldierCounter)
		middleLaneSoldierCounter += 1

func _on_InnerRightLane_gui_input(event):
	if isClicked(event) and innerRightLaneSoldierCounter < maxManpowerPerLane and !zeroManpowerReached and !isFightFaze:
		spawnSomething(innerRightLane, innerRightContestPoint.position, innerRightLaneSoldierCounter)
		innerRightLaneSoldierCounter += 1

func _on_OuterRightLane_gui_input(event):
	if isClicked(event) and outerRightLaneSoldierCounter < maxManpowerPerLane and !zeroManpowerReached and !isFightFaze:
		spawnSomething(outerRightLane, outerRightContestPoint.position, outerRightLaneSoldierCounter)
		outerRightLaneSoldierCounter += 1

func spawnSomething(lane, destination, counter):
	if spawningSoldiersIsOn:
		var uid = UID.generateUniqueID()
		emit_signal("spawnSoldier", getSpawnPointForSoldier(lane), destination, counter, uid)
		emit_signal("tellEnemySoldierSpawnedSignal", lane.name, uid)

func getSpawnPointForSoldier(lane : Control):
	var x = lane.rect_size.x/2
	var y = lane.rect_size.y * 0.9
	var spawnPoint = lane.rect_position + Vector2(x, y)
	return spawnPoint
	
func isClicked(event):
	if event is InputEventMouseButton:
		if event.pressed:
			return true
	return false

func _on_UnitSpawnsButtons_spawnSoldiersFlag(flag):
	spawningSoldiersIsOn = flag

func _on_UnitSpawnsButtons_spawnTanksFlag(flag):
	spawningTanksIsOn = flag

func _on_Game_zeroManpowerReachedSignal():
	zeroManpowerReached = true

func _on_Game_fightFazeEnded():
	outerLeftLaneSoldierCounter = 0
	innerLeftLaneSoldierCounter = 0
	middleLaneSoldierCounter = 0
	innerRightLaneSoldierCounter = 0
	outerRightLaneSoldierCounter = 0
	isFightFaze = false

func _on_Game_fightFateStartingSignal():
	isFightFaze = true
