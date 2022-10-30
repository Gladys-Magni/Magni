extends Area2D

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
const distructiondistance=600
var distanceToShip=0
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
		global_position += movement.normalized()*SPEED/100
		distanceToShip=Vector2(self.global_position-startpos).length()
		if(distanceToShip>distructiondistance):
			print("dist")
			_explode()		#for body in get_overlapping_bodies():
			#if(body!=player):
				#explode()
			#queue_free() #delete object

	pass

	
func _on_EnemyProjectile_body_entered(body):
	if(!body.is_in_group("Enemies")):
		_explode()
	if(body.is_in_group("Boat")):
		body.health-=0.2
	pass # Replace with function body.
	
	#pass # Replace with function body.


func _on_explosion_animation_finished():
	queue_free()
	pass # Replace with function body.




func _on_EnemyProjectile_area_entered(area):
	if(!area.is_in_group("Enemies") and !area.is_in_group("EnemieProjectile")):
		_explode()
	if(area.is_in_group("Boat")):
		area.health-=0.2
	pass # Replace with function body.


func _on_VisibilityNotifier2D_screen_exited():
	_explode()
	pass # Replace with function body.


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	_explode()
	pass # Replace with function body.


