extends CharacterBody2D

var direccion
const gravity := 40
var distancia
var distanciainicial : float
var catapultforce := 40
var playerpositionx := 0
var speed := 1.5
var player

var explosion = preload("res://Enemies/fire/explosion.tscn")
@onready var origen_explosion_marker_2d: Marker2D = $OrigenExplosionMarker2D
@onready var sprite_2d: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	distanciainicial = player.position.x - position.x
	playerpositionx = player.global_position.x
	distanciainicial *= -1 if distanciainicial < 0 else 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	direccion = (player.position - position).normalized()
	distancia = global_position.x - playerpositionx
	distancia *= -1 if distancia < 0 else 1
	if distancia > (distanciainicial/2):
		velocity.y = -catapultforce
	else:
		velocity.y = gravity
	velocity.x = 100
	velocity.x *= 1 if sprite_2d.flip_h == true else -1 
	move_and_slide()
	

func fireExplosion():
	var explode = explosion.instantiate()
	explode.global_position = origen_explosion_marker_2d.global_position
	get_parent().call_deferred("add_child", explode)



func _on_area_2d_body_entered(body: Node2D) -> void:
	fireExplosion()
	queue_free()
