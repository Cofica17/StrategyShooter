extends Node2D

export var spriteNeutralImagePath : String
export var spriteBlueImagePath : String
export var spriteRedImagePath : String
var contestPointSprite : Sprite

var contestPointArea : Area2D

var blueSoldierPresent = false
var redSoldierPresent = false

export var buffPercentage : float

var isFightFaze = false

var buffIsApplied = false
onready var values = get_tree().get_root().get_node("Game/AllHealthAndDamageValues")

signal buffApplied

func _ready():
	contestPointArea = get_node("ContestPointBody/ContestPointArea")
	contestPointSprite = get_node("ContestPointBody/ContestPointSprite")
	if spriteNeutralImagePath.length() != null:
		contestPointSprite.texture = load(spriteNeutralImagePath)

func _physics_process(delta):
	if isFightFaze:
		changeContestPointHolder()
		
func checkIsThereSoldierOnContestPoint(soldierName):
	for body in contestPointArea.get_overlapping_bodies():
		if soldierName in body.name:
			return true
	return false
	
func changeContestPointHolder():
	if blueSoldierPresent && redSoldierPresent:
		contestPointSprite.texture = load(spriteNeutralImagePath)
	elif blueSoldierPresent:
		contestPointSprite.texture = load(spriteBlueImagePath)
	elif redSoldierPresent:
		contestPointSprite.texture = load(spriteRedImagePath)
	else:
		contestPointSprite.texture = load(spriteNeutralImagePath)

func applyBuff():
	pass

func removeBuff():
	pass

func _on_ContestPointArea_body_entered(body):
	blueSoldierPresent = checkIsThereSoldierOnContestPoint("AllySoldier")
	redSoldierPresent = checkIsThereSoldierOnContestPoint("EnemySoldier")

func _on_ContestPointArea_body_exited(body):
	pass

func _on_Game_fightFazeEnded():
	removeBuff()
	applyBuff()
	emit_signal("buffApplied")
	isFightFaze = false
	contestPointSprite.texture = load(spriteNeutralImagePath)
	blueSoldierPresent = false
	redSoldierPresent = false

func _on_Game_fightFateStartingSignal():
	isFightFaze = true
