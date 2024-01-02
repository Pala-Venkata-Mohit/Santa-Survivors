extends Control

var upgradeCount
var timeRemain
const saveCountdown = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	upgradeCount = 0
	loadGame()
	$"Load Bar".max_value = saveCountdown
	$"Load Timer".start(saveCountdown)

func _physics_process(_delta):
	$"Load Bar".set_value($"Load Timer".get_time_left())

func loadGame():
	var config = ConfigFile.new()
	var err = config.load("user://santa-survivor.cfg")
	
	if err != OK:
		# gold
		Gold.changeGold(0)
		
		# upgrades meta
		Upgrades.changeUpgrades(0)
		Upgrades.changeLimitBreak(false)
		
		# upgrades
		Upgrades.changeHealth(0)
		Upgrades.changeRegen(0)
		Upgrades.changeCurse(0)
		Upgrades.changeAmount(0)
		Upgrades.changeSpeed(0)
		Upgrades.changeGreed(0)
		Upgrades.changeProjectileSpeed(0)
		Upgrades.changeProjectileTimeout(0)
		
		# shop
	else:
		# gold
		var goldLoad = config.get_value("santa", "gold")
		if (goldLoad == null):
			Gold.changeGold(0)
		else:
			Gold.changeGold(goldLoad)
			
		# upgrades
		var healthLoad = config.get_value("santa", "healthUpgrade")
		if (healthLoad == null):
			Upgrades.changeHealth(0)
		else:
			Upgrades.changeHealth(healthLoad)

		var regenLoad = config.get_value("santa", "regenUpgrade")
		if (regenLoad == null):
			Upgrades.changeRegen(0)
		else:
			Upgrades.changeRegen(regenLoad)

		var curseLoad = config.get_value("santa", "curse")
		if (curseLoad == null):
			Upgrades.changeCurse(0)
		else:
			Upgrades.changeCurse(curseLoad)

		var amountLoad = config.get_value("santa", "amount")
		if (amountLoad == null):
			Upgrades.changeAmount(0)
		else:
			Upgrades.changeAmount(amountLoad)

		var speedLoad = config.get_value("santa", "speed")
		if (speedLoad == null):
			Upgrades.changeSpeed(0)
		else:
			Upgrades.changeSpeed(speedLoad)

		var greedLoad = config.get_value("santa", "greed")
		if (greedLoad == null):
			Upgrades.changeGreed(0)
		else:
			Upgrades.changeGreed(greedLoad)

		var projSpeedLoad = config.get_value("santa", "projSpeed")
		if (projSpeedLoad == null):
			Upgrades.changeProjectileSpeed(0)
		else:
			Upgrades.changeProjectileSpeed(projSpeedLoad)

		var projTimeoutLoad = config.get_value("santa", "projTimeout")
		if (projTimeoutLoad == null):
			Upgrades.changeProjectileTimeout(0)
		else:
			Upgrades.changeProjectileTimeout(projTimeoutLoad)

		# meta upgrades
		var upgradeLoad = config.get_value("santa", "upgrades")
		if (upgradeLoad == null):
			Upgrades.changeUpgrades(upgradeCount)
		else:
			Upgrades.changeUpgrades(upgradeLoad)
		
		var limBrkLoad = config.get_value("santa", "limitBreak")
		if (limBrkLoad == null):
			Upgrades.changelimitBreak(false)
		else:
			Upgrades.changelimitBreak(limBrkLoad)

func _on_load_timer_timeout():
	get_tree().change_scene_to_file("res://Game/Scenes/Ui/Main Menu.tscn")
