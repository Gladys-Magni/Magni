extends Node2D

onready var explosion= $explosion
onready var spr = $cannonBallTexture


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dmg=50
var exploding=false
var movement=Vector2()
var startpos=Vector2()
var SPEED = 500
var distructiondistance = 300
var distanceToShip=0
func _length(var vec):
	return sqrt(vec.x*vec.x+vec.y*vec.y)
func _explode():
	spr.hide()
	explosion.show()
	exploding=true
	explosion.play("explosion")
	$EXPLOSION.play()
# Called when the node enters the scene tree for the first time.
func _ready():
	explosion.hide()
	pass # Replace with function body.

func _splash():
	spr.hide()
	explosion.hide()
	exploding=true
	$splash.play()
	$SPLASH.play()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(!exploding):		
		global_position += movement.normalized()*SPEED/100
		distanceToShip=Vector2(self.global_position-startpos).length()
		if(distanceToShip>distructiondistance):
			_splash()		#for body in get_overlapping_bodies():
			#if(body!=player):
				#explode()
			#queue_free() #delete object

	pass
	

func _on_CannonBall_area_entered(area):
	if(!area.is_in_group("CannonBalls")):
		_explode()
	if(area.is_in_group("Enemies")):
		area.hp-=dmg
		_explode()
		

func _on_CannonBall_body_entered(body):
	if(!body.is_in_group("Boat")):
		_explode()
	
	#pass # Replace with function body.


func _on_explosion_animation_finished():
	queue_free()
	pass # Replace with function body.




func _on_VisibilityNotifier2D_viewport_exited(viewport):
	_explode()
	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_exited():
	_explode()
	pass # Replace with function body.


func _on_splash_animation_finished():
	queue_free()
