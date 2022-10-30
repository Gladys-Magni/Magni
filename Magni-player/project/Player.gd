extends Node2D

onready var boat = $Boat

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 20
var velocity = Vector2()

var cannon_ball= preload("res://projectile/CannonBall.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("backward"):
		velocity.y += 1
	if Input.is_action_pressed("forward"):
		velocity.y -= 1
	if Input.is_action_just_pressed("shoot"):
		var cannonBall = cannon_ball.instance()
		get_tree().current_scene.add_child(cannonBall)
		cannonBall.global_position=boat.global_position
		cannonBall.startpos=boat.global_position
		var dir = boat.global_position.direction_to(get_global_mouse_position())
		dir.normalized()
		cannonBall.movement= dir


	velocity = velocity.normalized() * speed
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()
	set_position(get_position() + velocity)
	#velocity = Vector2(0,0)
	#
