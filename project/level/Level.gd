extends Node2D

const tileAmount := 5
const tileSize := 400

const zoneDensity := 0.25
const zoneSize := 20

const sizeX := tileSize * tileAmount
const sizeY := tileSize * tileAmount
const playerSpawn := Vector2(0,0)

var upperLeft = Vector2(0,0)
var bottomRight = Vector2(sizeX, sizeY)

var dangerZoneSprite = preload("res://level/DangerZoneSprite.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	initBackground()
	placeEnemyZones()
	placeIslands()
	
	
func placeEnemyZones():
	var zoneAmount = floor(tileAmount * tileAmount * zoneDensity)
	var i = 0
	while i < zoneAmount:
		var x = floor(rand_range(upperLeft.x,bottomRight.x))
		var y = floor(rand_range(upperLeft.y,bottomRight.y))
		if (x < playerSpawn.x and x + zoneSize > playerSpawn.x):
			if y < playerSpawn.y and y + zoneSize > playerSpawn.y:
				continue
		
		i += 1
		var zone = dangerZoneSprite.instance()
		zone.position = Vector2(x,y)
		$Zones.add_child(zone)
				
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
	tile.frames = $WaterSprite.frames
	tile.animation = "waves"	
	tile.centered = true
	tile.playing = true
	tile.speed_scale = 1
	tile.offset = Vector2(x,y)
	$Water.add_child(tile)
	
	
func _physics_process(delta):
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
