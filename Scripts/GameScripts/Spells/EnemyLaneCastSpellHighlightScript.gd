extends Sprite

var artillerySpellTextue = preload("res://Spell Casts/Bombing/BombingSelected.png")
var minesSpellTexture = preload("res://Spell Casts/Mines/MineSelected.png")
var isPressed = false

func _ready():
	pass

func _on_Lane_artilleryButtonClicked():
	if isPressed:
		texture = null
		isPressed = false
	else:
		texture = artillerySpellTextue
		isPressed = true

func _on_Lane_minesButtonClicked():
	if isPressed:
		texture = null
		isPressed = false
	else:
		texture = minesSpellTexture
		isPressed = true
