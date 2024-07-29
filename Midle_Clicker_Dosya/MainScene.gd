extends Node2D

# Değişkenler
var gold = 0
var energy = 1000
var max_energy = 1000
var energy_per_click = 20
var gold_per_click = 20
var energy_recharge_rate = 5  # Saniyede artacak enerji miktarı
var recharge_time = 0.0

# UI Elemanları
var gold_label
var energy_bar
var tap_button
var energy_label
var btn_boosts

func _ready():
	# UI elemanlarını başlatma
	gold_label = $Control/GoldLabel
	energy_bar = $Control/EnergyBar
	tap_button = $Control/TapButton
	energy_label = $Control/EnergyLabel
	btn_boosts = $Control/HBoxContainer/ButtonBoosts  # Yol güncellendi

	# UI elemanlarını başlangıç değerleri ile güncelle
	gold_label.text = str(Global.gold)
	energy_bar.value = Global.energy
	energy_bar.min_value = 0
	energy_bar.max_value = Global.max_energy
	energy_label.text = str(Global.energy) + " / " + str(Global.max_energy)

	# TapButton'ın pressed sinyalini _on_TapButton_pressed işlevine bağlama
	if tap_button:
		tap_button.connect("pressed", Callable(self, "_on_TapButton_pressed"))
	else:
		print("TapButton düğümü bulunamadı")

	# Boosts butonunun sinyalini bağlama
	if btn_boosts:
		btn_boosts.connect("pressed", Callable(self, "_on_btn_boosts_pressed"))
	else:
		print("ButtonBoosts düğümü bulunamadı")

func _on_TapButton_pressed():
	if Global.energy >= Global.energy_per_click:
		Global.gold += Global.gold_per_click
		Global.energy -= Global.energy_per_click
		gold_label.text = str(Global.gold)
		energy_bar.value = Global.energy
		energy_label.text = str(Global.energy) + " / " + str(Global.max_energy)

func _process(delta):
	# Enerjiyi her saniye başına 5 artır
	Global.recharge_time += delta
	if Global.recharge_time >= 1.0:
		Global.recharge_time = 0
		if Global.energy < Global.max_energy:
			Global.energy += Global.energy_recharge_rate
			if Global.energy > Global.max_energy:
				Global.energy = Global.max_energy
			energy_bar.value = Global.energy
			energy_label.text = str(Global.energy) + " / " + str(Global.max_energy)

# Sahne geçiş fonksiyonu
func _on_btn_boosts_pressed():
	print("Button Boosts Pressed")
	get_tree().change_scene_to_file("res://BoostsScene.tscn")
