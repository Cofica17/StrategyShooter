extends TextureButton

var buttonPressedColor = "#878686"
var normalButtonColor = "#ffffff"

var isPressed = false

func _ready():
	self.disabled = true

func _on_ArtillerySpell_pressed():
	if isPressed:
		modulate = normalButtonColor
		isPressed = false
	else:
		modulate = buttonPressedColor
		isPressed = true


func _on_OuterLeftLane_artillerySpellCasted():
	emit_signal("pressed")


func _on_InnerLeftLane_artillerySpellCasted():
	emit_signal("pressed")


func _on_MiddleLane_artillerySpellCasted():
	emit_signal("pressed")


func _on_InnerRightLane_artillerySpellCasted():
	emit_signal("pressed")


func _on_OuterRightLane_artillerySpellCasted():
	emit_signal("pressed")


func _on_Game_fightFateStartingSignal():
	self.disabled = false

func _on_Game_fightFazeEnded():
	self.disabled = true
