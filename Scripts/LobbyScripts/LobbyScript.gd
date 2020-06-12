extends Node2D

export (NodePath) var advertiserPath: NodePath
onready var advertiser := get_node(advertiserPath)

var lobbyName : String

var playerConnected := "Connected"
var playerNotConnected := "Waiting..."

var bothPlayerConnected = false

#Skripta koja poziva netowrkin api za postavljanje servera i otvara lobby koji drugi igrac moze vidjeti

func _ready():
	if get_tree().is_network_server():
		setLobbyName()
		advertiser.serverInfo["name"] = lobbyName
		advertiser.serverInfo["port"] = Networking.CONNECTION_PORT
		
		#Setting players connection status
		setPlayerConnected("PlayerNames/PlayerOneName", playerConnected)
		setPlayerConnected("PlayerNames/PlayerTwoName", playerNotConnected)
		
		#Connect to signals when player two connects or disconnects
		Networking.connect("playerConnectedSignal", self, "playerTwoConnected")
		Networking.connect("playerDisconnectedSignal", self, "playerTwoDisconnected")
		
	else:
		Networking.connect("hostDisconnectedSignal", self, "hostDisconnected")
		setPlayerConnected("PlayerNames/PlayerTwoName", playerConnected)
		setPlayerConnected("PlayerNames/PlayerOneName", playerConnected)
		get_node("Buttons/StartGameButton").disabled = true
		
func _process(delta):
		advertiser.serverInfo["full"] = bothPlayerConnected

func setLobbyName():
	for ipAdress in IP.get_local_addresses():
		if isIpAdress(ipAdress):
			var splitIpAdress = ipAdress.rsplit(".", false, 0)
			lobbyName = "Lobby " + splitIpAdress[3]
			print(lobbyName)
			get_node("LobbyName").text = lobbyName
			return
	
func isIpAdress(var ipAdress):
	var splitIpAdress = ipAdress.rsplit(".", false, 0)
	if splitIpAdress.size() == 4:
		return true
	return false
	
func playerTwoConnected():
	setPlayerConnected("PlayerNames/PlayerTwoName", playerConnected)
	bothPlayerConnected = true
	
func playerTwoDisconnected():
	setPlayerConnected("PlayerNames/PlayerTwoName", playerNotConnected)
	bothPlayerConnected = false

func hostDisconnected():
	get_tree().set_network_peer(null)
	get_tree().change_scene("res://Scenes/StartMenuScreen.tscn")

func setPlayerConnected(node, connected):
	get_node(node).text = connected

sync func startGame():
	get_tree().change_scene("res://Scenes/GameScene.tscn")

func _on_StartGameButton_pressed():
	if bothPlayerConnected:
		rpc("startGame")
