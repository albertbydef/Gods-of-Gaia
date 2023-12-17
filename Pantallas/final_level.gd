extends CanvasLayer
var nextlevel : String
var flechas_fuego := 0
var flechas_hielo := 0
var flechas_electro := 0

func _on_button_next_level_pressed() -> void:
	saveLevel()
	get_tree().paused = false
	get_tree().change_scene_to_file(nextlevel)
	


func _on_button_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_button_quit_pressed() -> void:
	saveLevel()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Pantallas/main_menu.tscn")

func saveLevel():
	Global.flechas_hielo = flechas_hielo
	Global.flechas_fuego = flechas_fuego
	Global.flechas_electro = flechas_electro
	Global.save_data()
	Save.save_data()

func scorelvl(score, scoreA, scoreB):
	$VBoxContainer/HBoxContainer/LabelScore.text = str(score)
	if score >= scoreA:
		$VBoxContainer/HBoxContainer2/LabelNoteA.show()
	if score < scoreA and score >= scoreB:
		$VBoxContainer/HBoxContainer2/LabelRateB.show()
	if score < scoreB:
		$VBoxContainer/HBoxContainer2/LabelRateC.show()
	
	
