extends "res://Scripts/GameScripts/ContestPoint/ContestPointScript.gd"

func _ready():
	pass

func applyBuff():
	if blueSoldierPresent:
		buffIsApplied = true
		values.soldierDamage *= values.cpDamageMultiplier

func removeBuff():
	if buffIsApplied:
		values.soldierDamage /= values.cpDamageMultiplier
		buffIsApplied = false
