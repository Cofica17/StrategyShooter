extends "res://Scripts/GameScripts/ContestPoint/ContestPointScript.gd"

func _ready():
	pass

func applyBuff():
	if blueSoldierPresent:
		buffIsApplied = true
		values.towerShootingCooldown /= values.cpTowerShootingCooldownReduction

func removeBuff():
	if buffIsApplied:
		values.towerShootingCooldown *= values.cpTowerShootingCooldownReduction
		buffIsApplied = false
