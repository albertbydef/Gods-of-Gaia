extends Node

var nextlevel = "res://Niveles/gaialvl_8_desert.tscn"
var scoreA = 5000
var scoreB = 2500

func _on_final_level_body_entered(body: Node2D) -> void:
	if body is player:
		body.finishedLevel(nextlevel, scoreA, scoreB)
		Global.lvl8 = false


func _on_game_over_1_body_entered(body: Node2D) -> void:
	if body is player:
		body.takeDmg(9999)


func _on_game_over_2_body_entered(body: Node2D) -> void:
	if body is player:
		body.takeDmg(9999)


func _on_game_over_3_body_entered(body: Node2D) -> void:
	if body is player:
		body.takeDmg(9999)


func _on_game_over_4_body_entered(body: Node2D) -> void:
	if body is player:
		body.takeDmg(9999)
