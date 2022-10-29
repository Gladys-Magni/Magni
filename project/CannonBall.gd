extends Node2D

onready var explosion= $Explosion
onready var spr = $Sprite
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var exploding=false
var movement=Vector2()
var startpos=Vector2()
const SPEED = 50
const distructiondistance=60
func _length(var vec):
	return sqrt(vec.x*vec.x+vec.y*vec.y)
func _explode():
	spr.hide()
	explosion.show()
	exploding=true
	explosion.play("explosion")
# Called when the node enters the scene tree for the first time.
func _ready():
	explosion.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(!exploding):		
		global_position+= movement
		if(_length(self.global_position-startpos)>distructiondistance):
			_explode()
		#for body in get_overlapping_bodies():
			#if(body!=player):
				#explode()
			#queue_free() #delete object

	pass
	

func _on_CannonBall_area_entered(area):
	if(_length(self.global_position-startpos)>10):
		_explode()

	#pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_exited():
	_explode()
	pass # Replace with function body.


func _on_CannonBall_body_entered(body):
	if(_length(self.global_position-startpos)>10):
		_explode()
	#pass # Replace with function body.


func _on_Explosion_animation_finished():
	queue_free()
	pass # Replace with function body.


