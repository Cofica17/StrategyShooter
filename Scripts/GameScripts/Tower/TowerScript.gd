extends KinematicBody2D

onready var values = get_tree().get_root().get_node("Game/AllHealthAndDamageValues")

var TowerHealth
onready var TowerHealthNode = get_node("TowerHealth")

var shootingAnimation : AnimatedSprite
export (PackedScene) var towerBulletModel
var shootingRange : Area2D
var towerTurret
var towerShootCooldown : Timer
var enemies : Array
var bulletOffset

var enemyTowerController

export var towerTurretSpritePath : String

var towerDamage

var idle = true

func _ready():

	shootingAnimation = get_node("TowerTurret/ShootingAnimation")
	towerTurret = get_node("TowerTurret")
	shootingRange = get_node("TowerArea2D")
	towerShootCooldown = get_node("TowerShootCooldown")
	enemyTowerController = get_tree().get_root().get_node("Game/EverythingEnemy/EnemyTowerController")
	towerTurret.texture = load(towerTurretSpritePath)
	
	TowerHealth = values.towerHealth
	towerDamage = values.towerDamage
	towerShootCooldown.wait_time = values.towerShootingCooldown
	
	displayingTowerHealth()

func _process(delta):
	var idle = true
	for body in shootingRange.get_overlapping_bodies():
		if towerShootCooldown.is_stopped():
			if self.name == "MyTower" and "EnemySoldier" in body.name:
				idle = false
				towerTurret.look_at(body.position)
				towerTurret.rotation_degrees += 90
				shoot(body.global_position)
				enemyTowerController.shootEnemy(body.uid, towerDamage)
				towerShootCooldown.start()
				
func displayingTowerHealth():
	TowerHealthNode.text = str(TowerHealth)

func shoot(positionToMoveTowards):
	shootingAnimation.visible = true
	shootingAnimation.play()
	var bullet : KinematicBody2D = towerBulletModel.instance()	
	bullet.wayToGo = -1
	bullet.rotation_degrees = 180		
	towerTurret.add_child(bullet)
	bullet.damage = towerDamage
	bullet.position = shootingAnimation.position
	bullet.positionToMoveTowards = positionToMoveTowards
	
remote func enemyTowerShoot(uid, damage):
	for body in shootingRange.get_overlapping_bodies():
		if "AllySoldier" in body.name:
			if body.uid == uid:
				towerTurret.look_at(body.position)
				towerTurret.rotation_degrees += 90
				shootingAnimation.visible = true
				shootingAnimation.play()
				var bullet : KinematicBody2D = towerBulletModel.instance()
				towerTurret.add_child(bullet)
				bullet.damage = damage
				bullet.position = shootingAnimation.position
				bullet.positionToMoveTowards = body.global_position
	
func _on_ShootingAnimation_animation_finished():
	shootingAnimation.visible = false
	shootingAnimation.stop()
	shootingAnimation.frame = 0

func _on_OuterRightContestPoint_buffApplied():
	towerShootCooldown.wait_time = values.towerShootingCooldown
