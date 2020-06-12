extends Node

# How often to broadcast out to the network that this host is active
export (float) var broadcast_interval: float = 0.01
var serverInfo := {"name": "LAN Game", "full": false}

var socketUDP: PacketPeerUDP
var broadcastTimer := Timer.new()
var broadcastPort := Networking.BROADCAST_PORT

func _enter_tree():
	broadcastTimer.wait_time = broadcast_interval
	broadcastTimer.one_shot = false
	broadcastTimer.autostart = true
	if get_tree().is_network_server():
		add_child(broadcastTimer)
		broadcastTimer.connect("timeout", self, "broadcast") 
		socketUDP = PacketPeerUDP.new()
		socketUDP.set_broadcast_enabled(true)
		socketUDP.set_dest_address('255.255.255.255', broadcastPort)
		
		#Kada je na hotspotu ne moze se slat na globa broadcast adresu vec se mora nac lokalna mreza i na nju slat broadcast
		#u ovom slucaju je to 192.168.43.255 sad pitanje je jel bi na nekom drugom mobu to bilo 192.168.X.255 zato treba uzet
		#ip adresu maknut zadnji value i appendat 255 pad ce radit normalno
		#socketUDP.set_dest_address('192.168.43.255', broadcastPort)

func broadcast():
	#print('Broadcasting game...')
	var packetMessage := to_json(serverInfo)
	var packet := packetMessage.to_ascii()
	socketUDP.put_packet(packet)

func _exit_tree():
	broadcastTimer.stop()
	if socketUDP != null:
		socketUDP.close()
