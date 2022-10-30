extends Node2D

# implements the Enemy class

class_name Enemy
onready var cannon_ball= preload("res://projectile/EnemyProjectile.tscn")
onready var collection= get_node("/root/Game/ProjectileCollection")
var direction=Vector2()
# speed the object moves with
var speed

# range of sight as circles
var sight
var closest
var chillzone=100
# health points
var hp = 500
var maxhp = 500
# player (only one for now)
var player
var cametoclose
# maps the function name of the attack to the wait time (attack speed)
var attack_map

# current direction as vector
var velocity_vector

# move in random direction when inactive
var random_vector

# move random for i iterations
var random_i

# literally dying right now
var dying

func _init(speed = 5, sight = 300, closest=50, hp = 100):
	self.closest=closest
	self.speed = speed
	self.sight = sight
	self.hp = hp
	self.maxhp=hp
	attack_map = {}
	random_vector = Vector2()
	random_i = 0
	dying = false
	

# Called when the node enters the scene tree for the first time.
func _ready():
	# load player when entering tree
	player = get_node("/root/Game/Kapitaen")
	register_attacks()

func move():
	var tooClose = in_rang(closest)
	if dying:
		return
	elif in_rang(sight) and !tooClose:
		move_towards_player()
	else:
		move_random()

# get player position and move towards him
func move_towards_player():
	velocity_vector = get_delta_vector()
	velocity_vector = velocity_vector.normalized() * speed;
	direction=velocity_vector
	set_position(get_position() + velocity_vector)

func move_random():
	if(random_i > 0):
		set_position(get_position() + random_vector)
		random_i -= 1
	else:
		random_vector.x = rand_range(-1, 1)
		random_vector.y = rand_range(-1, 1)
		random_vector = random_vector.normalized() * 0.2
		random_i = rand_range(0, 500)
	

# check if player is in sight
# pythagoras: root of (x²+y²) = radius
func in_rang(var rang):
	var delta_vector = get_delta_vector()
	return delta_vector.length() <= rang

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
func shoot():
	if(!in_rang(sight)):
		return
	var cannonBall = cannon_ball.instance()
	collection.add_child(cannonBall)
	cannonBall.global_position=self.global_position
	cannonBall.startpos=self.global_position
	cannonBall.movement= direction

func _die():
	dying = true

func _physics_process(delta):
	move()
	if(!hp>0):
		_die()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
