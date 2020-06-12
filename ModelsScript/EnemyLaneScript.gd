extends Control

var isArtilleryPressed = false
var isMinesPressed = false
var isMovementSpeedUpPressed = false

var artilleryAnimationFrames = preload("res://Models/SpellModels/ArtillerySpellFrames.tres")
var movementSpeedUpAnimationFrames = preload("res://Models/SpellModels/MovementSpeedUpFrames.tres")
var spellAnimation : AnimatedSprite
var spellRpcController : Node

var mineModel = preload("res://Models/SpellModels/MineSpellScene.tscn")

signal artillerySpellCasted
signal artilleryButtonClicked

signal minesSpellCasted
signal minesButtonClicked


func _ready():
	spellAnimation = get_node("SpellAnimation")
	spellRpcController = get_tree().get_root().get_node("Game/Containers/SpellRpcContainer")
	
func _gui_input(event):
	if isClicked(event) and isArtilleryPressed:
		spellRpcController.doArtillerySpellCasted(self.name)
		spellAnimation.frames = artilleryAnimationFrames
		spellAnimation.play()
		emit_signal("artillerySpellCasted")
	elif isClicked(event) and isMinesPressed:
		spellRpcController.doMineSpellCasted(self.name)
		var mine = mineModel.instance()
		self.add_child(mine)
		mine.global_position = getCenterOfLane()
		emit_signal("minesSpellCasted")
		
func isClicked(event):
	if event is InputEventMouseButton:
		if event.pressed:
			return true
	return false

func _on_ArtillerySpell_pressed():
	if !isArtilleryPressed:
		isArtilleryPressed = true
	else:
		isArtilleryPressed = false
	emit_signal("artilleryButtonClicked")

func _on_SpellAnimation_animation_finished():
	spellAnimation.stop()
	spellAnimation.frames = null
	spellAnimation.flip_v = false

func _on_MinesSpell_pressed():
	if !isMinesPressed:
		isMinesPressed = true
	else:
		isMinesPressed = false
	emit_signal("minesButtonClicked")

func movementSpeedUpSpellCastedByEnemy():
	spellAnimation.flip_v = true
	spellAnimation.frames = movementSpeedUpAnimationFrames
	spellAnimation.play()
	
func getCenterOfLane():
	var x = self.rect_size.x/2
	var y = self.rect_size.y/2
	var spawnPoint = self.rect_position + Vector2(x, y)
	return spawnPoint
