extends Node2D

const tileAmount := 5
const tileSize := 400

const zoneDensity := 0.25
const zoneSize := 20
const enemyDensity := 2

const islandDensity = 0.1

const sizeX := tileSize * tileAmount
const sizeY := tileSize * tileAmount
const playerSpawn := Vector2(0,0)

var upperLeft = playerSpawn + floor(tileAmount * tileSize / 2) * Vector2(-1, -1)
var bottomRight = playerSpawn + ceil((tileAmount + 1) * tileSize / 2) * Vector2(1, 1)

var dangerZoneSprite = preload("res://level/DangerZoneSprite.tscn")
var island1 = preload("res://level/Island1.tscn")
var island2 = preload("res://level/Island2.tscn")
var island3 = preload("res://level/Island3.tscn")
var islands = [island2, island3]
var enemyBoat = preload("res://enemy/EnemyBoat.tscn")
var coin = preload("res://loot/Loot.tscn")

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
	var islandAmount = floor(tileAmount * tileAmount * islandDensity)
	var i = 0
	while i < islandAmount:
		var x = floor(rand_range(upperLeft.x,bottomRight.x))
		var y = floor(rand_range(upperLeft.y,bottomRight.y))
		if abs(playerSpawn.x - x) < 400 or abs(playerSpawn.y - y) < 400:
			continue
		var failed = false
		for child in $Islands.get_children():
				if abs(child.position.x - x) < 400 or abs(child.position.y - y) < 400:
					failed = true
					break
		if failed:
			continue
		randomize()
		islands.shuffle()
		var island = islands[0].instance()
		island.position = Vector2(x, y)
		$Islands.add_child(island)
		i += 1
	
	
func initBackground():
	for x in range(sizeX / tileSize):
		for y in range(sizeY / tileSize):
			placeSprite(upperLeft.x + x * tileSize + tileSize / 2, upperLeft.y + y * tileSize + tileSize / 2)
			
			
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
	
	
func checkShopProximity(pos):
	for island in $Islands.get_children():
		if abs((pos - island.position).length()) < 300:
			return true
	
	return false
	
	
func displayShop(playerPosition):
	$Shop.visible = true
	$Shop.rect_position = playerPosition - Vector2(800, 450)
	
	
func removeShop():
	$Shop.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
