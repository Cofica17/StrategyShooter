extends TextureButton

var buttonPressedColor = "#878686"
var normalButtonColor = "#ffffff"

var isPressed = false

func _ready():
	self.disabled = true

func _on_MinesSpell_pressed():
	if isPressed:
		modulate = normalButtonColor
		isPressed = false
	else:
		modulate = buttonPressedColor
		isPressed = true

func _on_Game_fightFateStartingSignal():
	disabled = false

func _on_Game_fightFazeEnded():
	disabled = true

func _on_OuterLeftLane_minesSpellCasted():
	emit_signal("pressed")

func _on_InnerLeftLane_minesSpellCasted():
	emit_signal("pressed")

func _on_MiddleLane_minesSpellCasted():
	emit_signal("pressed")

func _on_InnerRightLane_minesSpellCasted():
	emit_signal("pressed")

func _on_OuterRightLane_minesSpellCasted():
	emit_signal("pressed")
