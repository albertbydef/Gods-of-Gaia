extends Area2D

var damage := 50
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.takeDmg(damage)
		animated_sprite_2d.play("explosion")
		await (animated_sprite_2d.animation_finished)
		queue_free()
	if body.is_in_group("terreno"):
		animated_sprite_2d.play("explosion")
		await (animated_sprite_2d.animation_finished)
		queue_free()
