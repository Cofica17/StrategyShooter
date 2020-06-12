extends KinematicBody2D

onready var values = get_tree().get_root().get_node("Game/AllHealthAndDamageValues")

var speed : float

var positionToMoveTowards
var isFightFaze = false
var stop = false
var isEnemySoldier = false

var shootingAnimation
export (PackedScene) var soldierBulletModel
var pointToShootFrom
var shootingRange
var shootingCooldown : Timer
var bodies : Array
var healthBar : ProgressBar

export var walkingAnimationEnemy : SpriteFrames
export var shootingAnimationEnemy : SpriteFrames

var soldierDamage

var uid

var enemyController
var soldierBulletsContainer

var idle = false

var healthSetFlag = false

func _ready():
	shootingAnimation = get_node("ShootingAnimation")
	pointToShootFrom = get_node("PointToShootFrom")
	shootingRange = get_node("ShootingRange")
	shootingCooldown = get_node("ShootingCooldown")
	healthBar = get_node("HealthBar") 
	enemyController = get_tree().get_root().get_node("Game/EverythingEnemy/Containers/EnemySoldierContainer/EnemyController")
	soldierBulletsContainer = get_tree().get_root().get_node("Game/Containers/SoldierBulletsContainer")
	
	soldierDamage = values.soldierDamage
	shootingCooldown.wait_time = values.soldierShootingCooldown
	healthBar.max_value = values.soldierHealth
	healthBar.value = values.soldierHealth
	speed = values.soldierSpeed

	self.name = "AllySoldier"
	
func _physics_process(delta):
	if positionToMoveTowards != null:
		if isFightFaze:
			if !healthSetFlag:
				enemyController.setEnemyHealth(uid, values.soldierHealth)
				healthSetFlag = true
			if !stop:
				moveSoldier()

	bodies = shootingRange.get_overlapping_bodies()
	if !bodies.empty():
		if anySoldiersOrTowerInArray():
			for body in bodies:
				if shootingCooldown.is_stopped():
					if "EnemySoldier" in body.name && "AllySoldier" in self.name:
						idle = false
						look_at(body.position)
						rotation_degrees += 90
						shoot(body.global_position)
						enemyController.enemySoldierShoot(self.uid, body.uid, self.soldierDamage)
						shootingCooldown.start()
					elif "EnemyTower" in body.name:
						look_at(body.position)
						rotation_degrees += 90
						shoot(body.global_position)
						shootingCooldown.start()
		else:
			rotation = 0
			stop = false
	else:
		rotation = 0
		stop = false

func anySoldiersOrTowerInArray():
	for body in bodies:
		if "EnemySoldier" in body.name && "AllySoldier" in self.name:
			return true
		elif "EnemyTower" in body.name && "AllySoldier" in self.name:
			return true
		elif "ContestPoint" in body.name:
			return true
	return false

func moveSoldier():
	var oldPosition = self.position
	var new_position = positionToMoveTowards
	var movement = new_position - self.position;
	movement = speed * movement.normalized()
	self.move_and_slide(movement, Vector2(0,0))
	var newPosition = self.position
	var newEnemyPos = newPosition - oldPosition
	enemyController.moveEnemySoldier(self.uid, newEnemyPos)

func killYourself():
	call_deferred("queue_free")

func _on_Area2D_body_entered(body):
	if body.name == "EnemyTower":
		stop = true
	elif body.name == "MyTower":
		stop = true
	elif "EnemySoldier" in body.name && "AllySoldier" in self.name:
		stop = true
	elif "AllySoldier" in body.name && "EnemySoldier" in self.name:
		stop = true

func shoot(positionToMoveTowards):
	print(str(soldierDamage))
	shootingAnimation.visible = true
	shootingAnimation.play()
	var bullet : KinematicBody2D = soldierBulletModel.instance()
	
	if "AllySoldier" in name:
		bullet.wayToGo = -1
		bullet.rotation_degrees = 180
		
	soldierBulletsContainer.add_child(bullet)
	bullet.position = pointToShootFrom.global_position
	bullet.positionToMoveTowards = positionToMoveTowards
	bullet.damage = soldierDamage

func getShot(damage):
	enemyController.enemySoldierShot(self.uid, damage)
	healthBar.value -= damage
	if healthBar.value <= 0:
		enemyController.removeMySoldier(self.uid)
		killYourself()

func changeMovementSpeed(multiplier):
	speed *= multiplier

func _on_ShootingAnimation_animation_finished():
	shootingAnimation.visible = false
	shootingAnimation.stop()
	shootingAnimation.frame = 0

func _on_SoldierArea_body_entered(body):
	if "ContestPoint" in body.name:
		idle = true
		stop = true
