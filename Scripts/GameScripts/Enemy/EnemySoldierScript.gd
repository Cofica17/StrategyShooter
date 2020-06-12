extends KinematicBody2D

var positionToMoveTowards

export var walkingAnimationEnemy = preload("res://Sprites/Units/RedSoldierAnimation/EnemyWalkingAnimation/EnemyWalkingAnimation.tres")
export var shootingAnimationEnemy = preload("res://Sprites/Units/RedSoldierShootingAnimation/EnemyShootingAnimation.tres")
var walkingAnimation : AnimatedSprite
var isFightFaze : bool = false

var shootingAnimation
var soldierBulletModel = preload("res://Models/GameModels/SoldierBulletModel.tscn")
var pointToShootFrom
var shootingRange
var shootingCooldown : Timer
var bodies : Array
var healthBar : ProgressBar

var uid
var enemyController
var soldierBulletsContainer 

func _ready():
	shootingAnimation = get_node("ShootingAnimation")
	pointToShootFrom = get_node("PointToShootFrom")
	shootingRange = get_node("ShootingRange")
	shootingCooldown = get_node("ShootingCooldown")
	healthBar = get_node("HealthBar") 
	walkingAnimation = get_node("WalkingAnimation")
	soldierBulletsContainer = get_tree().get_root().get_node("Game/Containers/SoldierBulletsContainer")
	
	enemyController = get_tree().get_root().get_node("Game/EverythingEnemy/Containers/EnemySoldierContainer/EnemyController")
	
	walkingAnimation.frames = walkingAnimationEnemy
	walkingAnimation.flip_v = true
	
	shootingAnimation.frames = shootingAnimationEnemy
	shootingAnimation.flip_v = true
	
	rotation_degrees = 180
	self.name = "EnemySoldier"
	
func moveSoldier(pos):
	self.position -= pos

func shoot(positionToMoveTowards, damage):
	shootingAnimation.visible = true
	shootingAnimation.play()
	var bullet : KinematicBody2D = soldierBulletModel.instance()
	
	bullet.wayToGo = -1
	bullet.rotation_degrees = 180
		
	soldierBulletsContainer.add_child(bullet)
	bullet.position = pointToShootFrom.global_position
	bullet.positionToMoveTowards = positionToMoveTowards
	bullet.damage = damage

func setMaxHealth(health):
	healthBar.max_value = health
	healthBar.value = health

func getShot(damage):
	healthBar.value -= damage
	if healthBar.value <= 0:
		enemyController.removeEnemySoldier(self.uid)
		killYourself()

func killYourself():
	call_deferred("queue_free")

func _on_SoldierArea_body_entered(body):
	pass
	
func _on_Area2D_body_entered(body):
	pass
	
func _on_ShootingAnimation_animation_finished():
	shootingAnimation.visible = false
	shootingAnimation.stop()
	shootingAnimation.frame = 0
