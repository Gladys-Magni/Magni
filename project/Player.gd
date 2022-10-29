extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 20
var velocity = Vector2()




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
	velocity = velocity.normalized() * speed
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()
	set_position(get_position() + velocity)
	#velocity = Vector2(0,0)
	#
