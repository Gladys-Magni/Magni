extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player := get_node("/root/Game/Kapitaen")

const baseCost := 10
const baseStats = {"Health": 1, "CannonBalls": 1, "DamageMultiplicator": 1, "BoatSpeed": 1, "Range": 1, "ReloadTime": 5}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Reload_Button_pressed():
	player.increaseLevel()

func _on_Damage_Button_pressed():
	player.increaseLevel()

func _on_Health_Button_pressed():
	player.increaseLevel()
	
func _on_Speed_Button_pressed():
	player.increaseLevel()
	
func _on_Ball_Button_pressed():
	player.increaseLevel()
	
func _on_Range_Button_pressed():
	player.increaseLevel()
