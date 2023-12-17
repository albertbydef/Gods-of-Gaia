extends Area2D

var direccion : Vector2
var speed := 1.5
var damage := 35

var explosion = preload("res://Enemies/fire/explosion.tscn")
@onready var origen_explosion_marker_2d: Marker2D = $OrigenExplosionMarker2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.direction_to(direccion)
	global_position += speed * direccion * delta 
	

func _on_body_entered(body: Node2D) -> void:
	fireExplosion()
	queue_free()

func fireExplosion():
	var explode = explosion.instantiate()
	explode.global_position = origen_explosion_marker_2d.global_position
	get_parent().call_deferred("add_child", explode)
