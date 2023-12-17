extends Node

var nextlevel = "res://Niveles/gaialvl_4_frozen_forest.tscn"
var scoreA = 5000
var scoreB = 2500

func _on_magic_fruit_body_entered(body: Node2D) -> void:
	if body is player:
		body.finishedLevel(nextlevel, scoreA, scoreB)
		Global.lvl4 = false


func _on_game_over_1_body_entered(body: Node2D) -> void:
	if body is player:
		body.takeDmg(9999)
