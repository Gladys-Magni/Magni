extends Node2D

# implements the Enemy class

class_name Enemy

# speed the object moves with
var speed

# range of sight as circles
var sight

# health points
var hp

# player (only one for now)
var player

# maps the function name of the attack to the wait time (attack speed)
var attack_map

func _init(speed = 5, sight = 300, hp = 100):
	self.speed = speed
	self.sight = sight
	self.hp = hp
	attack_map = {}
	

# Called when the node enters the scene tree for the first time.
func _ready():
	# load player when entering tree
	player = get_node("/root/Game/Kapitaen")
	register_attacks()

# get player position and move towards him
func move():
	var velocity_vector = get_delta_vector()
	velocity_vector = velocity_vector.normalized() * speed;
	set_position(get_position() + velocity_vector)

# check if player is in sight
# pythagoras: root of (x²+y²) = radius
func in_sight():
	var delta_vector = get_delta_vector()
	return sqrt(pow(delta_vector.x, 2) + pow(delta_vector.y, 2)) <= sight

# get distance vector towards player
func get_delta_vector():
	var current_pos = get_position()
	var player_pos = player.get_position()
	var delta_x = player_pos.x - current_pos.x
	var delta_y = player_pos.y - current_pos.y

	return Vector2(delta_x, delta_y)

# register all available attacks
func register_attacks():
	for key in attack_map:
		register_attack(key, attack_map[key])

# register one attack by creating a timer which gets called every 'wait_time'
func register_attack(attack_name, wait_time):
	var attack_timer = Timer.new()
	attack_timer.one_shot = false
	attack_timer.wait_time = wait_time
	attack_timer.connect("timeout", self, attack_name)
	
	add_child(attack_timer)
	attack_timer.start()

# add attack to attack_map, needs name and time interval
func add_attack(attack_name, wait_time):
	attack_map[attack_name] = wait_time

func _physics_process(delta):
	if(in_sight()):
		move()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
