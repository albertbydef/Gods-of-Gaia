extends CharacterBody2D

var speed := 120
var direccion := 0.0
var jump := 200
const gravity = 8

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var origen_arma_right_marker_2d: Marker2D = $OrigenArmaRightMarker2D
@onready var origen_arma_left_marker_2d: Marker2D = $OrigenArmaLeftMarker2D



var flecha_normal = preload("res://flechas/flecha_normal.tscn")
func _input(event: InputEvent) -> void:
	var arrow = flecha_normal.instantiate()
	if Input.is_action_just_pressed("ui_accept"):
		Input.action_press("ui_accept")
		animated_sprite_2d.play("shot")
		if animated_sprite_2d.flip_h:
			arrow.direccion = Vector2(-100, 0)
			arrow.get_child(1).flip_h = true
			arrow.global_position = origen_arma_left_marker_2d.global_position
		else:
			arrow.direccion = Vector2(100, 0)
			arrow.global_position = origen_arma_right_marker_2d.global_position
		get_parent().add_child(arrow)

func _physics_process(delta: float) -> void:
	if !Input.is_action_just_pressed("ui_accept"):
		direccion = Input.get_axis("run_left", "run_right")
		velocity.x = direccion * speed
		if direccion != 0:
			animated_sprite_2d.play("run")
		else:
			animated_sprite_2d.play("idle")
		animated_sprite_2d.flip_h = direccion < 0 if direccion != 0 else animated_sprite_2d.flip_h
		if is_on_floor() and Input.is_action_just_pressed("jump"):
			velocity.y -= jump
		if !is_on_floor():
			velocity.y += gravity
			if velocity.y < 0:
				animated_sprite_2d.play("jumpup")
			else:
				animated_sprite_2d.play("jumpfall")
		move_and_slide()
