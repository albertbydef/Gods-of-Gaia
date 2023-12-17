extends CharacterBody2D

var direccion := -1
var direccionshot := -1
var speed := 20
var canChangeDireccion := true
var player
enum estados {PATRULLAR, ANGRY, MUERTO}
var estadoActual = estados.PATRULLAR
var colision
var oneshot := false
var animationplay := false

var health := 75
var damage := 10
var score := 1000

@onready var ray_cast_suelo: RayCast2D = $Raycast/RayCastSuelo
@onready var ray_cast_pared: RayCast2D = $Raycast/RayCastPared
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var raycast: Node2D = $Raycast
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var ray_timer: Timer = $Raycast/RayTimer
@onready var ray_cast_detector_player: RayCast2D = $RayCastDetectorPlayer
@onready var hurt_timer: Timer = $HurtTimer
@onready var origen_slash_right_marker_2d: Marker2D = $OrigenSlashRightMarker2D
@onready var origen_slash_left_marker_2d: Marker2D = $OrigenSlashLeftMarker2D
@onready var shot_timer: Timer = $ShotTimer



var bomb = preload("res://Enemies/fire/catapult_bomb.tscn")


func _ready() -> void:
	animated_sprite_2d.play("walk")

func _physics_process(delta: float) -> void:
	velocity.x = direccion * speed
	if !is_on_floor():
		velocity.y += 9
	move_and_slide()

func _process(delta: float) -> void:
	colision = ray_cast_detector_player.get_collider()
	if player == null and ray_cast_detector_player.is_colliding():
		if colision.is_in_group("player"):
			player = colision
			estadoActual = estados.ANGRY
			
	
	if estadoActual == estados.ANGRY and player != null:
		bombAttack()
			
	if player != null and !ray_cast_detector_player.is_colliding():
		if animated_sprite_2d.flip_h:
			direccion = 1
		else:
			direccion = -1
		speed = 20
		animated_sprite_2d.play("walk")
		player = null
		estadoActual = estados.PATRULLAR
		animationplay = false
		oneshot = false
		
	if estadoActual == estados.PATRULLAR:
		if canChangeDireccion and (ray_cast_pared.is_colliding() or !ray_cast_suelo.is_colliding()):
			canChangeDireccion = false
			ray_timer.start()
			changeDirection()
		
	animated_sprite_2d.flip_h = true if direccionshot == 1 else false
	collision_shape_2d.scale.x = -0.1 if direccionshot == 1 else 0.1
	
func changeDirection():
	direccion *= -1
	direccionshot *= -1
	raycast.scale.x *= -1
	ray_cast_detector_player.scale.x *= -1

func takeDmg(dmg):
	health -= dmg
	var jugador = get_tree().get_nodes_in_group("player")
	if health <= 0:
		estadoActual = estados.MUERTO
		animated_sprite_2d.modulate = Color(1,1,1,1)
		animated_sprite_2d.play("dead")
		for jgdr in jugador:
			jgdr.sumScore(score)
		await (animated_sprite_2d.animation_finished)
		queue_free()
	else:
		animated_sprite_2d.modulate = Color(1,0,0.01,1)
		hurt_timer.start()
		for jgdr in jugador:
			if global_position.x < jgdr.global_position.x and direccion < 0:
				changeDirection()
			if global_position.x > jgdr.global_position.x and direccion > 0:
				changeDirection()

		

func bombAttack():
	var bombing = bomb.instantiate() 
	if !animationplay:
		animated_sprite_2d.play("throw")
		animationplay = true
		direccion = 0
	if animated_sprite_2d.flip_h:
		bombing.player = player
		bombing.get_child(0).flip_h = true
		bombing.global_position = origen_slash_right_marker_2d.global_position
	else:
		bombing.player = player
		bombing.global_position = origen_slash_left_marker_2d.global_position
	if !oneshot:
		get_parent().add_child(bombing)
		oneshot = true
		shot_timer.start(1)

func _on_ray_timer_timeout() -> void:
	canChangeDireccion = true


func _on_damage_player_body_entered(body: Node2D) -> void:
	if body is player:
		body.takeDmg(damage)


func _on_shot_timer_timeout() -> void:
	oneshot = false


func _on_hurt_timer_timeout() -> void:
	animated_sprite_2d.modulate = Color(1,1,1,1)
