extends Node2D

func _ready():
	pass 

func _on_BackButton_pressed():
	get_tree().set_network_peer(null)
	get_tree().change_scene("res://Scenes/StartMenuScreen.tscn")
