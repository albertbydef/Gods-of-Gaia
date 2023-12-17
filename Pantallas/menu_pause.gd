extends CanvasLayer


func _on_button_continue_pressed() -> void:
	hide()
	get_tree().paused = false


func _on_button_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_button_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Pantallas/main_menu.tscn")
