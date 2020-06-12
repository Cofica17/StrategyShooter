extends Node

var enemySoldiers : Array
var mySoldiers : Array

func _ready():
	pass 

func moveEnemySoldier(uid, speed):
	rpc("doMove", uid, speed)
	
remote func doMove(uid, speed):
	for soldier in enemySoldiers:
		if uid == soldier.uid:
			soldier.moveSoldier(speed)

func enemySoldierShoot(shooterUid, targetUid, damage):
	rpc("doShoot", shooterUid, targetUid, damage)
	
remote func doShoot(shooterUid, targetUid, damage):
	var positionToShootTowards = getPositionOfSoldier(targetUid)
	for soldier in enemySoldiers:
		if shooterUid == soldier.uid:
			soldier.shoot(positionToShootTowards, damage)
			
func enemySoldierShot(uid, damage):
	rpc("doEnemySoldierShot", uid, damage)
	
remote func doEnemySoldierShot(uid, damage):
	for soldier in enemySoldiers:
		if uid == soldier.uid:
			soldier.getShot(damage)
			
func setEnemyHealth(uid, health):
	rpc("doEnemySetHealth", uid, health)
	
remote func doEnemySetHealth(uid, health):
	for soldier in enemySoldiers:
		if uid == soldier.uid:
			soldier.setMaxHealth(health)

func getPositionOfSoldier(uid):
	for soldier in mySoldiers:
		if uid == soldier.uid:
			return soldier.global_position
			
func removeMySoldier(uid):
	var i = 0
	for soldier in mySoldiers:
		if uid == soldier.uid:
			mySoldiers.remove(i)
		i += 1

func removeEnemySoldier(uid):
	var i = 0
	for soldier in enemySoldiers:
		if uid == soldier.uid:
			enemySoldiers.remove(i)
		i += 1
