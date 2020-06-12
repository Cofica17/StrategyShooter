extends Node2D

export (NodePath) var serverListPath: NodePath
onready var serverList := get_node(serverListPath)

export (PackedScene) var lobbyInstance

var serverInfo
var serverNodePosition = 0
var serverNodeSizeY = 157

func _on_ServerSearcher_new_server(serverInfo):
	var serverNode = lobbyInstance.instance()
	
	serverNode.get_node("LobbyNamePositioner").get_node("LobbyName").text = serverInfo.name
	serverNode.get_node("JoinButtonPositioner").get_node("JoinButton").connect("button_down", self, "serverNode_onClick", [serverNode])
	
	serverNode.move_local_y(serverNodePosition, false)
	serverNodePosition += serverNodeSizeY
	serverList.add_child(serverNode)
	
	self.serverInfo = serverInfo
	serverNode.lobbyIP = serverInfo.ip

func serverNode_onClick(serverNode):
	Networking.joinLobby(serverNode.lobbyIP)
	if serverInfo.full:
		alert("Lobby currently full, cannot join", "Oops")
	else:
		get_tree().change_scene("res://Scenes/LobbyScene.tscn")
	
func _on_ServerSearcher_remove_server(serverIp):
	for serverNode in serverList.get_children():
		# Just a hacky way to identify the Node and remove it
		if serverNode.lobbyIP == serverIp:
			serverList.remove_child(serverNode)
			get_tree().change_scene("res://Scenes/LobbyBrowserScene.tscn")
			break
			
func alert(text: String, title: String='Message') -> void:
	var dialog = AcceptDialog.new()
	dialog.dialog_text = text
	dialog.window_title = title
	dialog.connect('modal_closed', dialog, 'queue_free')
	add_child(dialog)
	dialog.popup_centered()
