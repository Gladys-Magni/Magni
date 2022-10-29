extends Node2D

# implements the Enemy class

class_name Enemy

# velocity vector
var velocity_vector = Vector2()

# speed the object moves with
var speed := 0

# player (only one for now)
onready var player := get_node("/root/Game/Player")

func _init(speed = 10):
	velocity_vector = Vector2()
	velocity_vector.x = 1
	velocity_vector.y = 1
	self.speed = speed
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# get player position and move towards him
func move():
	var current_pos = get_position()
	var player_pos = player.get_position()
	velocity_vector.x = player_pos.x - current_pos.x
	velocity_vector.y = player_pos.y - current_pos.y
	velocity_vector = velocity_vector.normalized() * speed;
	set_position(get_position() + velocity_vector)
	#print(player.get_position())

func _physics_process(delta):
	move()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
