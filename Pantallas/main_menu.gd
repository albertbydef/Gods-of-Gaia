extends Node

@onready var v_box_container_levels: VBoxContainer = $VBoxContainerLevels
@onready var v_box_container_menu: VBoxContainer = $VBoxContainerMainMenu



func _ready() -> void:
	$VBoxContainerMainMenu/ButtonStartGame.grab_focus()
	Save.load_data()
	Global.load_data()
	$"VBoxContainerLevels/HBoxContainer/VBoxContainerForestLevels/ButtonNivel 1".disabled = Global.lvl1
	$"VBoxContainerLevels/HBoxContainer/VBoxContainerForestLevels/ButtonNivel 2".disabled = Global.lvl2
	$"VBoxContainerLevels/HBoxContainer/VBoxContainerForestLevels/ButtonNivel 3".disabled = Global.lvl3
	$"VBoxContainerLevels/HBoxContainer/VBoxContainerFrozenForestLevels/ButtonNivel 4".disabled = Global.lvl4
	$"VBoxContainerLevels/HBoxContainer/VBoxContainerFrozenForestLevels/ButtonNivel 5".disabled = Global.lvl5
	$"VBoxContainerLevels/HBoxContainer/VBoxContainerFrozenForestLevels/ButtonNivel 6".disabled = Global.lvl6
	$"VBoxContainerLevels/HBoxContainer/VBoxContainerDesertLevels/ButtonNivel 7".disabled = Global.lvl7
	$"VBoxContainerLevels/HBoxContainer/VBoxContainerDesertLevels/ButtonNivel 8".disabled = Global.lvl8

func _on_start_game_pressed() -> void:
	v_box_container_menu.hide()
	v_box_container_levels.show()
	$"VBoxContainerLevels/HBoxContainer/VBoxContainerForestLevels/ButtonNivel 1".grab_focus()


func _on_atras_pressed() -> void:
	v_box_container_menu.show()
	v_box_container_levels.hide()
	$VBoxContainerMainMenu/ButtonStartGame.grab_focus()


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_nivel_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Niveles/gaialvl_1Forest.tscn")


func _on_nivel_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Niveles/gaialvl_2_forest.tscn")


func _on_nivel_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Niveles/gaialvl_3_forest.tscn")


func _on_nivel_4_pressed() -> void:
	get_tree().change_scene_to_file("res://Niveles/gaialvl_4_frozen_forest.tscn")


func _on_nivel_5_pressed() -> void:
	get_tree().change_scene_to_file("res://Niveles/gaialvl_5_frozen_forest.tscn")


func _on_nivel_6_pressed() -> void:
	get_tree().change_scene_to_file("res://Niveles/gaialvl_6_frozen_forest.tscn")


func _on_nivel_7_pressed() -> void:
	get_tree().change_scene_to_file("res://Niveles/gaialvl_7_desert.tscn")


func _on_nivel_8_pressed() -> void:
	get_tree().change_scene_to_file("res://Niveles/gaialvl_8_desert.tscn")


func _on_controls_pressed() -> void:
	pass # Replace with function body.
