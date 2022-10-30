extends Node2D

onready var cannon=$shoot
onready var spr=$dontshoot
#onready var can=load("res://assets/stop.png")
#onready var stop=load("res://assets/icon.png")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hasMoved=false
var isInAngle=false
var lastPos=Vector2()
# Called when the node enters the scene tree for the first time.
func _isInAngle(var currentdirection,var mousedirection):
	var angle = currentdirection.angle_to(mousedirection)
	if(!hasMoved):return isInAngle
	if(angle<0):
		angle=abs(angle)
	if(angle>PI-(PI/6)):
		#Input.set_custom_mouse_cursor(stop,Input.CURSOR_ARROW,Vector2(16,16))
		spr.show()
		cannon.hide()
		isInAngle=false
		return false
	if(angle<(PI/6)):
		#Input.set_custom_mouse_cursor(stop,Input.CURSOR_ARROW,Vector2(16,16))
		#Input.set_costum_mouse_cursor(can,Input.CURSOR_ARROW,Vector2())
		spr.show()
		cannon.hide()
		isInAngle=false
		return false
	cannon.show()
	spr.hide()
	#Input.set_custom_mouse_cursor(null)
	#Input.set_custom_mouse_cursor(can,Input.CURSOR_ARROW,Vector2(16,16))
	isInAngle=true
	return true
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var cur = get_global_mouse_position()
	if(lastPos!=cur):
		hasMoved=true
	else:
		hasMoved=false
	cannon.global_position=get_global_mouse_position()
	spr.global_position=get_global_mouse_position()
	lastPos=cur
	pass
	

