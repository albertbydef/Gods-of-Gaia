extends CharacterBody2D

var direccion := -1
var speed := 20
const jump := 250
const gravity := 9
const jumpFactor := 0.5
var canChangeDireccion := true
var player
enum estados {PATRULLAR, ANGRY, MUERTO}
var estadoActual = estados.PATRULLAR
var colision

var is_jumping := false

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
@onready var ray_cast_attack: RayCast2D = $RayCastAttack


func _ready() -> void:
	animated_sprite_2d.play("walk")

func _physics_process(delta: float) -> void:
	if !is_jumping:
		velocity.x = direccion * speed
		if !is_on_floor():
			velocity.y += gravity
		move_and_slide()
	if is_jumping:
		
		var jumpdir = (player.position - position).normalized()
		var jumpdist = (player.position - position).length()
		if is_on_floor():
			velocity.y -= jump
			animated_sprite_2d.play("jump")
		if !is_on_floor():
			velocity.y += gravity
			animated_sprite_2d.play_backwards("jump")
		velocity.x = jumpdir.x * jumpdist
		move_and_slide()
		if is_on_floor():
			if is_jumping:
				is_jumping = false
		

func _process(delta: float) -> void:
	colision = ray_cast_detector_player.get_collider()
	if player == null and ray_cast_detector_player.is_colliding():
		if colision.is_in_group("player"):
			player = colision
			estadoActual = estados.ANGRY
			is_jumping = true
			
	if estadoActual == estados.ANGRY and player != null and !is_jumping:
		speed = 75
		animated_sprite_2d.speed_scale = 3.5
		if ray_cast_attack.is_colliding():
			speed = 50
			animated_sprite_2d.speed_scale = 1
			damage = 35
			animated_sprite_2d.play("attack")
		else:
			animated_sprite_2d.play("walk")
		var directionPlayer = global_position.direction_to(player.global_position)
		if directionPlayer.x < 0:
			direccion = -1
		elif directionPlayer.x > 0:
			direccion = 1
		
	if player != null and !ray_cast_detector_player.is_colliding() and !is_jumping:
		speed = 15
		animated_sprite_2d.play("walk")
		animated_sprite_2d.speed_scale = 1
		player = null
		estadoActual = estados.PATRULLAR
		damage = 10
		
	if estadoActual == estados.PATRULLAR:
		if canChangeDireccion and (ray_cast_pared.is_colliding() or !ray_cast_suelo.is_colliding()):
			canChangeDireccion = false
			ray_timer.start()
			changeDirection()
		
	animated_sprite_2d.flip_h = true if direccion == 1 else false
	collision_shape_2d.scale.x = -0.1 if direccion == 1 else 0.1

func changeDirection():
	direccion *= -1
	raycast.scale.x *= -1
	ray_cast_detector_player.scale.x *= -1
	ray_cast_attack.scale.x *= -1

func takeDmg(damage):
	health -= damage
	var jugador = get_tree().get_nodes_in_group("player")
	if health <= 0:
		estadoActual = estados.MUERTO
		animated_sprite_2d.modulate = Color(1,1,1,1)
		animated_sprite_2d.play("dead")
		await (animated_sprite_2d.animation_finished)
		for jgdr in jugador:
			jgdr.sumScore(score)
		queue_free()
	else:
		animated_sprite_2d.modulate = Color(1,0,0.01,1)
		hurt_timer.start()
		for jgdr in jugador:
			if global_position.x < jgdr.global_position.x and direccion < 0:
				changeDirection()
			if global_position.x > jgdr.global_position.x and direccion > 0:
				changeDirection()
		await (hurt_timer.timeout)
		animated_sprite_2d.modulate = Color(1,1,1,1)

func _on_ray_timer_timeout() -> void:
	canChangeDireccion = true


func _on_damage_player_body_entered(body: Node2D) -> void:
	if body is player:
		body.takeDmg(damage)

