extends Node2D

const tileAmount := 5
const tileSize := 400

const sizeX := tileSize * tileAmount
const sizeY := tileSize * tileAmount


# Called when the node enters the scene tree for the first time.
func _ready():
	initBackground()
	placeEnemyZones()
	placeIslands()
	
	
func placeEnemyZones():
	#logic to set enemy zones
	pass
	
	
func placeIslands():
	#logic to position the islands
	pass
	
func initBackground():
	for x in range(sizeX / tileSize):
		for y in range(sizeY / tileSize):
			placeSprite(x * tileSize + tileSize / 2, y * tileSize + tileSize / 2)
			
			
func placeSprite(x,y ):
	var tile = AnimatedSprite.new()
	tile.frames = $AnimatedSprite.frames
	tile.animation = "waves"	
	tile.centered = true
	tile.playing = true
	tile.speed_scale = 0.3
	tile.offset = Vector2(x,y)
	add_child(tile)
	
	
func _physics_process(delta):
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
