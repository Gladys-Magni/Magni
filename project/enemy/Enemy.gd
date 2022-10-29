extends Node2D

# implements the Enemy class

class_name Enemy

# speed the object moves with
var speed := 0

# range of sight as rectangle because circles are too hard >:)
var sight := 300

# player (only one for now)
onready var player := get_node("/root/Game/Player")

func _init(speed = 5):
	self.speed = speed
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# get player position and move towards him
func move():
	var velocity_vector = get_delta_vector()
	velocity_vector = velocity_vector.normalized() * speed;
	set_position(get_position() + velocity_vector)

# check if player is in sight
# pythagoras: root of (x²+y²) = radius
func in_sight():
	var delta_vector = get_delta_vector()
	#return abs(delta_vector.x) <= sight && abs(delta_vector.y) <= sight
	return sqrt(pow(delta_vector.x, 2) + pow(delta_vector.y, 2)) <= sight

func get_delta_vector():
	var current_pos = get_position()
	var player_pos = player.get_position()
	var delta_x = player_pos.x - current_pos.x
	var delta_y = player_pos.y - current_pos.y

	return Vector2(delta_x, delta_y)

func _physics_process(delta):
	if(in_sight()):
		move()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
