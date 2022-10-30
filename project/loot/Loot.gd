extends Node2D

class_name Loot

var loot_name

var loot_value

func _init(name = "", value = 0):
	self.loot_name = name
	self.loot_value = value

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	# TODO animation 
	pass

func _on_Loot_body_entered(body):
	print(loot_name + ": " + str(loot_value))
	queue_free()
