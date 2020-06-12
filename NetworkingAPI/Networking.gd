extends Node

#Skripta za spajanje preko lana

const CONNECTION_PORT = 43434
const BROADCAST_PORT = 3111
const NUMBER_OF_PLAYERS = 1

signal playerConnectedSignal
signal playerDisconnectedSignal
signal hostDisconnectedSignal

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	
func createLobby():
	var host = NetworkedMultiplayerENet.new()
	host.create_server(CONNECTION_PORT, NUMBER_OF_PLAYERS)
	get_tree().set_network_peer(host)
	
func joinLobby(var ip_adress):
	var client = NetworkedMultiplayerENet.new()
	client.create_client(ip_adress, CONNECTION_PORT)
	get_tree().set_network_peer(client)
	
func _player_connected(id):
	emit_signal("playerConnectedSignal")

func _player_disconnected(id):
	emit_signal("playerDisconnectedSignal")

func _connected_ok():	
	pass

func _server_disconnected():
	emit_signal("hostDisconnectedSignal")	

func _connected_fail():
	print("ne mogu se")

remote func register_player(info):
	pass
