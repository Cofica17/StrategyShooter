extends Node2D

#Ovdje se nalaze svi eventi vezani za buttone na start menu ekranu

#Dohvacanje buttona u varijable iz hirearhije
onready var createLobbyButton = get_node("CreateLobbyButton")
onready var joinLobbyButton = get_node("JoinLobbyButton")
onready var backToMainScreenButton = get_node("BackToMainScreenButton")

#Registriranje button down eventa na buttone
func _ready():
	createLobbyButton.connect("button_down", self, "onClick_createLobbyButton")
	joinLobbyButton.connect("button_down", self, "onClick_joinLobbyButton")
	backToMainScreenButton.connect("button_down", self, "onClick_backToMainScreenButton")

func onClick_createLobbyButton():
	Networking.createLobby()
	get_tree().change_scene("res://Scenes/LobbyScene.tscn")
	
	
func onClick_joinLobbyButton():
	get_tree().change_scene("res://Scenes/LobbyBrowserScene.tscn")
	
func onClick_backToMainScreenButton():
	get_tree().change_scene("res://Scenes/MainMenuScene.tscn")
