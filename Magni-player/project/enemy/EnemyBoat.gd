extends Enemy

class_name EnemyBoat

# speed of boat is 7
# add shoot as attack every 5 seconds
func _init():
	._init(2, 200, 100)
	add_attack("shoot", 5.0)

# shoot if the player is in range
func shoot():
	if(!in_sight()):
		return
	
	print("shoot")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
