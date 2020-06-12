extends Sprite

var movementSpeedUpTexture = preload("res://Spell Casts/MoveSpeedUp/MoveSpeed_Selected.png")
var isPressed = false

func _ready():
	pass 

func _on_Lane_movementSpeedUpButtonClicked():
	if isPressed:
		texture = null
		isPressed = false
	else:
		texture = movementSpeedUpTexture
		isPressed = true

