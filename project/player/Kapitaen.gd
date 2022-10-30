extends KinematicBody2D

const ACCELERATION = 1
const MAX_SPEED = 200
const FRICTION = 2
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
	print(mouseIcon.hasMoved)
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



func _on_timer_timeout():
	loaded=true
	pass # Replace with function body.
