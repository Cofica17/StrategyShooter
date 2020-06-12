extends Node

var spawnSoldierButton : TextureButton
var spawnTankButton : TextureButton

var buttonPressedColor = "#878686"
var normalButtonColor = "#ffffff"

signal spawnSoldiersFlag(flag)
signal spawnTanksFlag(flag)

func _ready():
	spawnSoldierButton = get_node("SpawnSoldier")
	spawnTankButton = get_node("SpawnTank")
	spawnSoldierButton.modulate = buttonPressedColor

func _on_SpawnSoldier_pressed():
	spawnSoldierButton.modulate = buttonPressedColor
	spawnTankButton.modulate = normalButtonColor
	emit_signal("spawnSoldiersFlag", true)
	emit_signal("spawnTanksFlag", false)

func _on_SpawnTank_pressed():
	spawnTankButton.modulate = buttonPressedColor
	spawnSoldierButton.modulate = normalButtonColor
	emit_signal("spawnSoldiersFlag", false)
	emit_signal("spawnTanksFlag", true)
