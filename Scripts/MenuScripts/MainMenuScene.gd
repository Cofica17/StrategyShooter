extends Node2D


onready var playButton = get_node("ColorRect/PlayButton")
onready var exitButton = get_node("ColorRect/ExitButton")
onready var settingsButton = get_node("ColorRect/SettingsButton")

var arrayy : Array
var num

func _ready():
	playButton.connect("button_down", self, "onClick_playButton")
	exitButton.connect("button_down", self, "onClick_exitButton")
	settingsButton.connect("button_down", self, "onClick_settingsButton")

func onClick_playButton():
	get_tree().change_scene("res://Scenes/StartMenuScreen.tscn")
	
func onClick_exitButton():
	get_tree().change_scene("")
	
func onClick_settingsButton():
	get_tree().change_scene("")

