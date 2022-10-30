extends Control

onready var prog=$enemybar
onready var boat=get_parent()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	set_global_position(boat.global_position+Vector2(-20,-40))
	prog.value=100*float(boat.hp)/float(boat.maxhp)
	pass
