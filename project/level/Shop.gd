extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player := get_node("/root/Game/Kapitaen")

const baseCost := 10
var cost = baseCost


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Reload_Button_pressed():
	if !canPay():
		return #display error
	player.pay(cost)	
	player.increaseLevel()
	player.decreaseReloadTime()
	if player.getReloadTime() <= 1:
		$"Reload Button".visible = false

func _on_Damage_Button_pressed():
	if !canPay():
		return #display error
	player.pay(cost)	
	player.increaseLevel()
	player.increaseDamage()
	if player.getDamageMultiplicator() >= 5:
		$"Damage Button".visible = false

func _on_Health_Button_pressed():
	if !canPay():
		return #display error
	player.pay(cost)	
	player.increaseLevel()
	player.increaseHealth()
	if player.getHealth() >= 5:
		$"Health Button".visible = false
	
func _on_Speed_Button_pressed():
	if !canPay():
		return #display error
	player.pay(cost)	
	player.increaseLevel()
	player.increaseBoatSpeed()
	if player.getBoatSpeed() >= 5:
		$"Speed Button".visible = false
	
func _on_Ball_Button_pressed():
	if !canPay():
		return #display error
	player.pay(cost)	
	player.increaseLevel()
	player.increaseCannonBalls()
	if player.getCannonBalls() >= 5:
		$"Ball Button".visible = false
	
func _on_Range_Button_pressed():
	if !canPay():
		return #display error
	player.pay(cost)
	player.increaseLevel()
	player.increaseRange()
	if player.getRange() >= 5:
		$"Range Button".visible = false
	
func canPay():
	return player.getCoins() >= cost
	
func _physics_process(delta):
	if !self.visible:
		return
		
	cost = player.getLevel() * baseCost
	$"Coin Display".text = str(player.getCoins()) + "/" + str(cost)
