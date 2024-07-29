extends Control

# UI Elemanları
var multitap_button
var energy_limit_button
var recharging_speed_button
var midle_bot_button
var gold_label

# Değişkenler
var multitap_level = 0
var energy_limit_level = 0
var recharging_speed_level = 0
var midle_bot_level = 0

# Maksimum seviyeler
var max_level = 20

func _ready():
	# UI elemanlarını başlatma
	multitap_button = $VBoxContainer/MultitapButton
	energy_limit_button = $VBoxContainer/EnergyLimitButton
	recharging_speed_button = $VBoxContainer/RechargingSpeedButton
	midle_bot_button = $VBoxContainer/MidleBOTButton
	gold_label = $VBoxContainer/GoldLabel

	# Düğme sinyallerini bağlama
	multitap_button.connect("pressed", Callable(self, "_on_multitap_button_pressed"))
	energy_limit_button.connect("pressed", Callable(self, "_on_energy_limit_button_pressed"))
	recharging_speed_button.connect("pressed", Callable(self, "_on_recharging_speed_button_pressed"))
	midle_bot_button.connect("pressed", Callable(self, "_on_midle_bot_button_pressed"))

	# Düğme metinlerini güncelle
	update_button_texts()

func _on_multitap_button_pressed():
	if multitap_level < max_level and Global.gold >= required_gold_for_upgrade(multitap_level):
		multitap_level += 1
		Global.gold -= required_gold_for_upgrade(multitap_level)
		update_button_texts()

func _on_energy_limit_button_pressed():
	if energy_limit_level < max_level and Global.gold >= required_gold_for_upgrade(energy_limit_level):
		energy_limit_level += 1
		Global.gold -= required_gold_for_upgrade(energy_limit_level)
		update_button_texts()

func _on_recharging_speed_button_pressed():
	if recharging_speed_level < max_level and Global.gold >= required_gold_for_upgrade(recharging_speed_level):
		recharging_speed_level += 1
		Global.gold -= required_gold_for_upgrade(recharging_speed_level)
		update_button_texts()

func _on_midle_bot_button_pressed():
	if midle_bot_level < 1 and Global.gold >= required_gold_for_upgrade(midle_bot_level):
		midle_bot_level += 1
		Global.gold -= required_gold_for_upgrade(midle_bot_level)
		update_button_texts()

func update_button_texts():
	multitap_button.text = "Multitap (" + str(multitap_level) + "/" + str(max_level) + ")"
	energy_limit_button.text = "Energy Limit (" + str(energy_limit_level) + "/" + str(max_level) + ")"
	recharging_speed_button.text = "Recharging Speed (" + str(recharging_speed_level) + "/" + str(max_level) + ")"
	midle_bot_button.text = "MidleBOT (" + str(midle_bot_level) + "/1)"
	gold_label.text = "Gold: " + str(Global.gold)

func required_gold_for_upgrade(level):
	return (level + 1) * 100  # Her seviye için gereken altın miktarını hesaplar
