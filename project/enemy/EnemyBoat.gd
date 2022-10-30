extends Enemy

class_name EnemyBoat

onready var animation_tree = $AnimationTree

# get deatch animation from scene tree
onready var death_animation = $DeathAnimation

onready var coin = preload("res://loot/Coin.tscn")

# speed of boat is 7
# add shoot as attack every 5 		seconds
func _init():
	._init(2, 500 ,100, 50)
	.add_attack("shoot", 1.0)
# shoot if the player is in range
func move_towards_player():
	.move_towards_player()
	update_sprite_direction()

func update_sprite_direction():
	var direction_vector = velocity_vector.normalized()
	var x = int(round(direction_vector.x))
	var y = int(round(direction_vector.y))
	animation_tree.set("parameters/Idle/blend_position", Vector2(x, y))
	
func play_death_animation():
	death_animation.show()
	death_animation.play()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _die():
	._die()
	$EnemyTexture.hide()
	play_death_animation()


func _on_Timer_timeout():
	.shoot()
	pass # Replace with function body.


func _on_DeathAnimation_animation_finished():
	drop_loot()
	queue_free()

func drop_loot():
	var one_coin = coin.instance()
	one_coin.position = get_position()
	var level = get_node("/root/Game/Level")
	level.add_child(one_coin)
