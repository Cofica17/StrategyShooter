extends Node

var enemyTower

func _ready():
	enemyTower = get_tree().get_root().get_node("Game/EverythingEnemy/EnemyTower")

func shootEnemy(uid, damage):
	rpc("doShootEnemy", uid, damage)

remote func doShootEnemy(uid, damage):
	enemyTower.enemyTowerShoot(uid, damage)
