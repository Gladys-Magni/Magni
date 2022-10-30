extends Node2D

const tileAmount := 5
const tileSize := 400

const zoneDensity := 0.25
const zoneSize := 20
const enemyDensity := 5

const sizeX := tileSize * tileAmount
const sizeY := tileSize * tileAmount
const playerSpawn := Vector2(0,0)

var upperLeft = Vector2(0,0)
var bottomRight = Vector2(sizeX, sizeY)

var dangerZoneSprite = preload("res://level/DangerZoneSprite.tscn")
var island1 = preload("res://level/Island.tscn")
var enemyBoat = preload("res://enemy/EnemyBoat.tscn")

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
		
		spawn_enemies(x, y)
		i += 1

func spawn_enemies(x, y):
		for j in range(enemyDensity):
			var enemyX = floor(rand_range(x, x + zoneSize))
			var enemyY = floor(rand_range(y, y + zoneSize))
			var enemy = enemyBoat.instance()
			enemy.position = Vector2(enemyX, enemyY)
			$EnemyCollection.add_child(enemy)



func placeIslands():
	var x = floor(rand_range(upperLeft.x,bottomRight.x))
	var y = floor(rand_range(upperLeft.y,bottomRight.y))
	var island = island1.instance()
	island.position = Vector2(300,300)
	$Islands.add_child(island)
	
	
func initBackground():
	for x in range(sizeX / tileSize):
		for y in range(sizeY / tileSize):
			placeSprite(x * tileSize + tileSize / 2, y * tileSize + tileSize / 2)
			
			
func placeSprite(x, y):
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
