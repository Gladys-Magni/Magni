extends Enemy

class_name EnemyBoat

# attack_timer
var attack_timer = null

# speed of boat is 7
func _init():
	._init(2, 200, 100)

# shoot if the player is in range
func shoot():
	if(!in_sight()):
		return
	
	print("shoot")

# Called when the node enters the scene tree for the first time.
func _ready():
	init_attack_timer()

# create new timer and add to tree as child
func init_attack_timer():
	attack_timer = Timer.new()
	attack_timer.one_shot = false
	attack_timer.wait_time = 5.0
	attack_timer.connect("timeout", self, "shoot")
	
	add_child(attack_timer)
	attack_timer.start()
	
