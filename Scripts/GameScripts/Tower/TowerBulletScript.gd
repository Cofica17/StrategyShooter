extends KinematicBody2D

export var speed : float

var positionToMoveTowards
var wayToGo = 1
var damage

func _ready():
	pass 

func _physics_process(delta):
	if positionToMoveTowards != null:
		fly(delta)

func fly(delta):
	var new_position = positionToMoveTowards
	var movement
	if wayToGo == -1:
		movement = self.global_position - new_position
	else:
		movement = new_position - self.global_position
	movement = speed * delta * movement.normalized() * wayToGo
	var isCollision = self.move_and_collide(movement)
	
	if isCollision != null:
		if "AllySoldier" in isCollision.collider.name:
			isCollision.collider.getShot(damage)
			call_deferred("queue_free")
		elif "EnemySoldier" in isCollision.collider.name:
			call_deferred("queue_free")

