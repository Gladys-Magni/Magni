extends Node2D
onready var cap=get_parent()
var count=5
var cannon_ball= preload("res://projectile/CannonBall.tscn")
onready var collection= get_node("/root/Game/ProjectileCollection")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _shoot(var shipPos, var toMouse, var Currentdirection):
	if(Currentdirection.y==0):#move right
		for i in count:
			var cannonBall = cannon_ball.instance()
			collection.add_child(cannonBall)
			cannonBall.global_position=shipPos+Vector2(10*(i-(count/2)),0)
			cannonBall.startpos=shipPos+Vector2(10*(i-(count/2)),0)
			cannonBall.movement= toMouse.normalized()
		#else:
			#use cannonsright
	else:
		for i in count:
			var cannonBall = cannon_ball.instance()
			collection.add_child(cannonBall)
			cannonBall.global_position=shipPos+Vector2(0,10*(i-(count/2)))
			cannonBall.startpos=shipPos+Vector2(0,10*(i-(count/2)))
			cannonBall.movement= toMouse.normalized()	
		#if(Mouse.x<0):
			#use cannonsleft
		#else:
			#use cannonsright
		#var cannonBall = cannon_ball.instance()
		#get_tree().current_scene.add_child(cannonBall)
		#cannonBall.global_position=shipPos
		#cannonBall.startpos=shipPos
		#cannonBall.movement= toMouse.normalized()#move left

# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
