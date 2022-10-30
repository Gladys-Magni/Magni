extends Node

export(int) var max_health = 1 setget set_max_health
var health = max_health setget set_health

signal no_health
signal health_changed(value)
signal max_health_changed(value)

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed")
	
func set_health(value):
	health = value
	emit_signal("Health_changed", health)
	if health <= 0:
		emit_signal("no_health")

# Called when the node enters the scene tree for the first time.
func _ready():
	self.health = max_health
	 # Replace with function body.



