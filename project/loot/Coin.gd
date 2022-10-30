extends Loot

class_name Coin

func _init():
	._init("coin", 1)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Loot_body_entered(body):
	var kapitaen = get_node("/root/Game/Kapitaen")
	kapitaen.increaseCoins()
	._on_Loot_body_entered(body)
