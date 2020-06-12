extends Node

signal strategyFazeStartingSignal
signal fightFateStartingSignal
signal zeroManpowerReachedSignal

onready var manpowerLeftLabel = get_node("GameMap/ManpowerLeftLabel")

onready var allySoldierContainer = get_node("Containers/SoldiersContainer")
onready var enemySoldierContainer = get_node("EverythingEnemy/Containers/EnemySoldierContainer") 

var startingManpower : int
var manpower : int
var manpowerLabelText = "Manpower left: "

var isFightFaze = false
var myFlagForEndOfFightFaze = false
var enemyFlagForEndOfFightFaze = false

onready var startOfStrategyFazeTimer : Timer = get_node("Timers/StartOfStrategyFazeTimer")
onready var durationOfStrategiFazeTimer : Timer = get_node("Timers/DurationOfStrategyFaze")
onready var startOfStrategyFazeUI = get_node("StartOfFazeBackground/StartOfFaze")

onready var values = get_node("AllHealthAndDamageValues")

signal fightFazeEnded

func _ready():
	startingManpower = values.maxManpower
	manpower = startingManpower
	startOfStrategyFazeTimer.start()

func _process(delta):
	manpowerLeftLabel.text = manpowerLabelText + str(manpower)
	if manpower == 0:
		emit_signal("zeroManpowerReachedSignal")
	
	if isFightFaze:
		myFlagForEndOfFightFaze = endFightFaze()
		rpc("checkEnemyFlagForEndOfFightFaze", myFlagForEndOfFightFaze)
		if myFlagForEndOfFightFaze && enemyFlagForEndOfFightFaze:
			myFlagForEndOfFightFaze = false
			enemyFlagForEndOfFightFaze = false
			despawnSoldiers()
			emit_signal("fightFazeEnded")
			isFightFaze = false
			startingManpower = values.maxManpower
			manpower = startingManpower

func despawnSoldiers():
	for soldier in allySoldierContainer.get_children():
		soldier.getShot(100000)

func endFightFaze():
	for soldier in allySoldierContainer.get_children():
		if !soldier.idle:
			return false
	if !get_node("MyTower").idle:
		return false
	return true

remote func checkEnemyFlagForEndOfFightFaze(flag):
	enemyFlagForEndOfFightFaze = flag

func _on_DurationOfStrategyFaze_timeout():
	emit_signal("fightFateStartingSignal")
	isFightFaze = true

func _on_Lanes_spawnSoldier(position, positionToMoveTowards, counterOfSoldiersAlreadyInLane, uid):
	manpower -= 1

func _on_StartOfStrategyFazeTimer_timeout():
	durationOfStrategiFazeTimer.start()
