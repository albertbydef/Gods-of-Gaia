extends Area2D

var direccion : Vector2
var speed := 2
var damage := 10
var damagePlus := 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.direction_to(direccion)
	global_position += speed * direccion * delta 
	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemigos") and !body.is_in_group("earth"):
		body.takeDmg(damage)
		queue_free()
	elif body.is_in_group("enemigos") and body.is_in_group("earth"):
		body.takeDmg(damagePlus)
		queue_free()
	
	if body.is_in_group("terreno"):
		queue_free()


func _on_kill_timer_timeout() -> void:
	queue_free()
