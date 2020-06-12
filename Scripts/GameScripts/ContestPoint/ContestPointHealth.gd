extends "res://Scripts/GameScripts/ContestPoint/ContestPointScript.gd"

func _ready():
	pass

func applyBuff():
	if blueSoldierPresent:
		buffIsApplied = true
		values.soldierHealth *= values.cpHealthMultiplier

func removeBuff():
	if buffIsApplied:
		values.soldierHealth /= values.cpHealthMultiplier
		buffIsApplied = false
