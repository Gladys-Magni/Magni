extends Control

onready var prog=$ProgressBar
onready var cap=get_node("/root/Game/Kapitaen")
onready var timer=get_node("/root/Game/Kapitaen/timer")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	set_global_position(cap.global_position+Vector2(100,100))
	if(!cap.loaded):
		prog.value=100-(timer.time_left*100)
	else:
		prog.value=100
	pass
