extends KinematicBody2D

var enemyTowerHealth
onready var enemyTowerNode = get_node("EnemyTowerHealth")

func _ready():
	enemyTowerHealth = 100
	displayingEnemyTowerHealth()
	
func displayingEnemyTowerHealth():
	enemyTowerNode.text = str(enemyTowerHealth)



