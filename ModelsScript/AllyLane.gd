extends Control

onready var values = get_tree().get_root().get_node("Game/AllHealthAndDamageValues")

var artilleryAnimationFrames = preload("res://Models/SpellModels/ArtillerySpellFrames.tres")
var movementSpeedUpAnimationFrames = preload("res://Models/SpellModels/MovementSpeedUpFrames.tres")
var spellAnimation : AnimatedSprite
var bodySize : CollisionShape2D
var laneArea : Area2D
var spellRpcController 

var mineModel = preload("res://Models/SpellModels/MineSpellScene.tscn")

var isMovementSpeedUpPressed = false

signal movementSpeedUpSpellCasted
signal movementSpeedUpButtonClicked

func _ready():
	spellRpcController = get_tree().get_root().get_node("Game/Containers/SpellRpcContainer")
	spellAnimation = get_node("SpellAnimation")
	laneArea = get_node("LaneArea")
	bodySize = get_node("LaneArea/CollisionShape2D")
	bodySize.shape.extents = self.get_rect().size
	
func _gui_input(event):
	if isClicked(event) and isMovementSpeedUpPressed:
		emit_signal("movementSpeedUpSpellCasted")
		spellAnimation.flip_v = false
		spellAnimation.frames = movementSpeedUpAnimationFrames
		spellAnimation.play()
		spellRpcController.doMovementSpeedUpSpellCasted(name)
		var soldiers = getAllSoldiersInLane()
		if !soldiers.empty():
			for soldier in soldiers:
				soldier.changeMovementSpeed(1.5)

func isClicked(event):
	if event is InputEventMouseButton:
		if event.pressed:
			return true
	return false
	
func getAllSoldiersInLane():
	var soldiers : Array
	for body in laneArea.get_overlapping_bodies():
		if "AllySoldier" in body.name:
			soldiers.append(body)
	return soldiers

func artillerySpellCastedByEnemy():
	spellAnimation.frames = artilleryAnimationFrames
	spellAnimation.play()
	
func mineSpellCastedByEnemy():
	var mine = mineModel.instance()
	add_child(mine)
	mine.global_position = getCenterOfLane()
	
func _on_SpellAnimation_animation_finished():
	spellAnimation.stop()
	
	if spellAnimation.frames == artilleryAnimationFrames:
		dealDamageInLane()
		
	spellAnimation.frames = null
	
func dealDamageInLane():
	var soldiers : Array = getAllSoldiersInLane()
	if !soldiers.empty():
		for soldier in soldiers:
			soldier.getShot(values.artilleryDamage)
			
func getCenterOfLane():
	var x = self.rect_size.x/2
	var y = self.rect_size.y/2
	var spawnPoint = self.rect_position + Vector2(x, y)
	return spawnPoint

func _on_MovementSpeedIncreaseSpell_pressed():
	if !isMovementSpeedUpPressed:
		isMovementSpeedUpPressed = true
	else:
		isMovementSpeedUpPressed = false
	emit_signal("movementSpeedUpButtonClicked")
