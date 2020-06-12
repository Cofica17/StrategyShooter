extends "res://Scripts/GameScripts/ContestPoint/ContestPointScript.gd"

func _ready():
	pass

func applyBuff():
	if blueSoldierPresent:
		buffIsApplied = true
		values.maxManpower += values.cpManpowerAddition

func removeBuff():
	if buffIsApplied:
		values.maxManpower -= values.cpManpowerAddition
		buffIsApplied = false
