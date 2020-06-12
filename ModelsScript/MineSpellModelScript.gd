extends Area2D

var mineSprite : Sprite
var explodeAnimation : AnimatedSprite
var spellRpcController


onready var values = get_tree().get_root().get_node("Game/AllHealthAndDamageValues")

func _ready():
	mineSprite = get_node("MineSprite")
	explodeAnimation = get_node("ExplodeAnimation")
	spellRpcController = get_tree().get_root().get_node("Game/Containers/SpellRpcContainer")

func _process(delta):
	for body in get_overlapping_bodies():
		if "AllySoldier" in body.name:
			blowUp()
			
func blowUp():
	mineSprite.visible = false
	explodeAnimation.visible = true
	explodeAnimation.play()

func _on_ExplodeAnimation_animation_finished():
	for soldier in getAllSoldiersInArea():
		soldier.getShot(values.mineDamage)
	queue_free()

func getAllSoldiersInArea():
	var soldiers : Array
	for body in get_overlapping_bodies():
		if "AllySoldier" in body.name:
			soldiers.append(body)
	return soldiers
