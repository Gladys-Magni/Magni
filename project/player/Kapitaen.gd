extends KinematicBody2D

const ACCELERATION = 1
const MAX_SPEED = 200
const FRICTION = 1
var inShop = false
var stats = {"Health": 1, "CannonBalls": 1, "Coins": 1000, "DamageMultiplicator": 1, "BoatSpeed": 1, "Range": 1, "ReloadTime": 5}
var level = 1
var health = 1

var velocity = Vector2.ZERO

var CurrentDirection = Vector2(0,1)
onready var boat=$boat
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var mouseIcon = get_node("/root/Game/MouseIcon")
onready var timer=$timer
onready var cannonCollection=$cannons
var loaded=true

func _set_up_cannon_ball():
	var dir = self.global_position.direction_to(get_global_mouse_position())
	cannonCollection._shoot(self.global_position,dir,CurrentDirection)
	
func _physics_process(delta):
	if inShop:
		if Input.is_action_pressed("escapeShop"):
			inShop = false
			var level = get_node("../Level")
			level.removeShop()
			self.visible = true
			var progressBar = get_node("../CannonProgress")
			progressBar.visible = true
		else:
			return
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("backward") - Input.get_action_strength("forward")

	
	if input_vector != Vector2.ZERO:

		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		CurrentDirection=input_vector
		velocity += input_vector * ACCELERATION * delta
		velocity = velocity.clamped(MAX_SPEED * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move_and_collide(velocity)

	if Input.is_action_just_pressed("shoot") and loaded:
	
		if(mouseIcon._isInAngle(CurrentDirection,self.global_position.direction_to(get_global_mouse_position()))):
				loaded=false
				timer.start()
				_set_up_cannon_ball()
	else:
		mouseIcon._isInAngle(CurrentDirection,self.global_position.direction_to(get_global_mouse_position()))

	if Input.is_action_just_pressed("interact"):
		var level = get_node("../Level")
		if level.checkShopProximity(self.position):
			self.visible = false
			var progressBar = get_node("../CannonProgress")
			progressBar.visible = false
			level.displayShop(self.position)
			inShop = true

func getMaxHealth():
	return stats["Health"]
	
func getHealth():
	return self.health
	
func getCannonBalls():
	return stats["CannonBalls"]
	
func getCoins():
	return stats["Coins"]
	
func getDamageMultiplicator():
	return stats["DamageMultiplicator"]
	
func getRange():
	return stats["Range"]
	
func getReloadTime():
	return stats["ReloadTime"]
	
func getBoatSpeed():
	return stats["BoatSpeed"]
	
func getLevel():
	return self.level
	
	
	
func increaseLevel():
	self.level += 1
	
func increaseHealth():
	self.stats["Health"] += 1
	self.health = self.stats["Health"]
	
func increaseDamage():
	self.stats["DamageMultiplicator"] += 1
	
func increaseCannonBalls():
	self.stats["CannonBalls"] += 1
	
func increaseBoatSpeed():
	self.stats["BoatSpeed"] += 1
	
func decreaseReloadTime():
	self.stats["ReloadTime"] -= 1
	
func increaseRange():
	self.stats["Range"] += 1
	
func pay(coins):
	self.stats["Coins"] -= coins
	


func _on_timer_timeout():
	loaded=true
	pass # Replace with function body.
