extends KinematicBody2D

signal grounded_updated(is_grounded)
signal life_changed(player_hearts)

const ACCELERATION = 35
const MAX_SPEED = 200
const FRICTION = 10

var max_hearts: int = 4
var hearts: float = max_hearts

var stats = PlayerStats
var velocity = Vector2.ZERO
var cannon_ball= preload("res://projectile/CannonBall.tscn")
onready var boat=$boat
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree

func _set_up_cannon_ball():
	var cannonBall = cannon_ball.instance()
	get_tree().current_scene.add_child(cannonBall)
	cannonBall.global_position=boat.global_position
	cannonBall.startpos=boat.global_position
	var dir = boat.global_position.direction_to(get_global_mouse_position())
	dir.normalized()
	cannonBall.movement= dir
	
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("backward") - Input.get_action_strength("forward")
	if Input.is_action_just_pressed("shoot"):
		_set_up_cannon_ball()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		velocity += input_vector * ACCELERATION * delta
		velocity = velocity.clamped(MAX_SPEED * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
func _ready():
	stats.connect("no_health", self, "queue_free")
	
	move_and_collide(velocity)
