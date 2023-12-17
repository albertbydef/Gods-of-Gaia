extends CharacterBody2D
class_name player

#Variable de següent nivell
var nextlevel : String

#Variable que controla l'Score necessaari de cada nivell per a cada nota
var scoreA := 0
var scoreB := 0
var scoreC := 0
var scoreD := 0

#Variables de moviment
var speed := 120
var direccion := 0.0
var jump := 220
const gravity = 8

#Variable de vida
var health := 0 :
	set(val):
		health = val
		$HPCanvasLayer/HBoxContainer/HPTextureProgressBar.value = val

#Variables de selecció de fletxa
var tipoflecha : int = 0

#Variables de numero de fletxes especials amb el seu setter
var numflechas_fuego := 0 :
	set(val):
		numflechas_fuego = val
		$FireArrowCanvasLayer/HBoxContainer/FireArrowLabel.text = str(numflechas_fuego)
var numflechas_hielo := 0:
	set(val):
		numflechas_hielo = val
		$IceArrowCanvasLayer2/HBoxContainer/IceArrowLabel.text = str(numflechas_hielo)
var numflechas_electro := 0:
	set(val):
		numflechas_electro = val
		$ElectroArrowCanvasLayer3/HBoxContainer/ElectroArrowLabel.text = str(numflechas_electro)

#Variable de Score
var score := 0:
	set(val):
		score = val
		$ScoreCanvasLayer2/HBoxContainer/ScoreLabel2.text = str(score)

#Variables de control de dispar
var canShot := true

#Variables de control d'animació
var animation = true

#Estats
enum estados {NORMAL, HERIDO, MUERTO, INVECIBLE}
var estadoActual = estados.NORMAL


#Nodes
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var origen_arma_right_marker_2d: Marker2D = $OrigenArmaRightMarker2D
@onready var origen_arma_left_marker_2d: Marker2D = $OrigenArmaLeftMarker2D
@onready var select_fire_canvas_layer: CanvasLayer = $SelectFireCanvasLayer
@onready var select_ice_canvas_layer: CanvasLayer = $SelectIceCanvasLayer
@onready var select_electro_canvas_layer: CanvasLayer = $SelectElectroCanvasLayer
@onready var shot_timer: Timer = $ShotTimer
@onready var animation_timer: Timer = $AnimationTimer
@onready var invincible_timer: Timer = $InvincibleTimer



#Tipus de fletxes
var flecha_normal = preload("res://Disparos/flecha_normal.tscn")
var flecha_fuego = preload("res://Disparos/flecha_fuego.tscn")
var flecha_hielo = preload("res://Disparos/flecha_hielo.tscn")
var flecha_electro = preload("res://Disparos/flecha_electro.tscn")

func _ready() -> void:
	numflechas_fuego = Global.flechas_fuego
	numflechas_hielo = Global.flechas_hielo
	numflechas_electro = Global.flechas_electro
	score = 0
	health = Global.health



#Control de dispar i selecció d'arma
func _input(event: InputEvent) -> void:
	var arrow = flecha_normal.instantiate()
	var fire = flecha_fuego.instantiate()
	var ice = flecha_hielo.instantiate()
	var electro = flecha_electro.instantiate()
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = true
		$MenuPause.show()
		$MenuPause.get_child(0).get_child(1).grab_focus()
		
	if Input.is_action_just_pressed("change_weapon"):
		select_tipoflecha()
		
	if Input.is_action_just_pressed("ui_accept") and canShot:
		canShot = false
		animation = false
		shot_timer.start()
		animation_timer.wait_time = 0.05
		animation_timer.start()
		match tipoflecha:
			0:
				disparo(arrow)
			1:
				if numflechas_fuego > 0:
					disparo(fire)
					restaSpecialArrow("Fuego")
				else:
					disparo(arrow)
			2:
				if numflechas_hielo > 0:
					disparo(ice)
					restaSpecialArrow("Hielo")
				else:
					disparo(arrow)
			3:
				if numflechas_electro > 0:
					disparo(electro)
					restaSpecialArrow("Electro")
				else:
					disparo(arrow)
			
		

#Funció de control de físiques del player
func _physics_process(delta: float) -> void:
	if estadoActual == estados.NORMAL or estadoActual == estados.INVECIBLE: 
		movimiento(delta)
	if estadoActual == estados.MUERTO:
		if !is_on_floor():
			velocity.y += gravity
			move_and_slide()

#Moviment del personatge
func movimiento(delta: float) -> void:
	direccion = Input.get_axis("run_left", "run_right")
	velocity.x = direccion * speed
	if direccion != 0 and animation:
			animated_sprite_2d.play("run")  
	elif animation:
		animated_sprite_2d.play("idle")
	animated_sprite_2d.flip_h = direccion < 0 if direccion != 0 else animated_sprite_2d.flip_h
	if is_on_floor() and Input.is_action_just_pressed("jump"):
			velocity.y -= jump
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y < 0 and animation:
			animated_sprite_2d.play("jumpup")
		elif animation:
			animated_sprite_2d.play("jumpfall")
	move_and_slide()


#Dispar del personatge
func disparo(arrow):
	if is_on_floor():
		animated_sprite_2d.play("shot")
	else:
		animated_sprite_2d.play("shotjump")
	if animated_sprite_2d.flip_h:
		arrow.direccion = Vector2(-100, 0)
		arrow.get_child(1).flip_h = true
		arrow.global_position = origen_arma_left_marker_2d.global_position
	else:
		arrow.direccion = Vector2(100, 0)
		arrow.global_position = origen_arma_right_marker_2d.global_position
	get_parent().add_child(arrow)

#Selecció de fletxa del personatge
func select_tipoflecha():
	tipoflecha += 1
	if tipoflecha == 4:
			tipoflecha = 0
	match tipoflecha:
			0:
				select_electro_canvas_layer.hide()
			1:
				select_fire_canvas_layer.show()
			2:
				select_ice_canvas_layer.show()
				select_fire_canvas_layer.hide()
			3:
				select_electro_canvas_layer.show()
				select_ice_canvas_layer.hide()

			
#Funció suma fletxes especials dels coleccionables
func takeSpecialArrow(arrow):
	if arrow == "Fuego":
		numflechas_fuego += 1
	elif arrow == "Hielo":
		numflechas_hielo += 1
	elif arrow == "Electro":
		numflechas_electro += 1

#Funció que resta fletxes especials
func restaSpecialArrow(arrow):
	if arrow == "Fuego":
		numflechas_fuego -= 1
	elif arrow == "Hielo":
		numflechas_hielo -= 1
	elif arrow == "Electro":
		numflechas_electro -= 1
#Funció suma puntuació score
func sumScore(scr):
	score += scr

#Temporitzador per tornar a disparar
func _on_shot_timer_timeout() -> void:
	canShot = true

#Temporitzador d'animació
func _on_animation_timer_timeout() -> void:
	animation = true
	if estadoActual == estados.INVECIBLE:
		animated_sprite_2d.modulate = Color(1,1,1,0.5)
	else:
		estadoActual = estados.NORMAL
		animated_sprite_2d.modulate = Color(1,1,1,1)
	
#Funció suma vida al player
func sumHealth(vida):
	health += vida
	if health > Global.maxHealth:
		health = Global.maxHealth
	
#Funció de control de mal del personatge
func takeDmg(damage):
	health -= damage
	if health <= 0:
		animation = false
		animation_timer.wait_time = 3
		animation_timer.start()
		estadoActual = estados.MUERTO
		animated_sprite_2d.play("dead")
		await (animated_sprite_2d.animation_finished)
		get_tree().paused = true
		$GameOverScreen.show()
		$GameOverScreen.get_child(0).get_child(1).grab_focus()
	else:
		animation = false
		animation_timer.start(0.5)
		estadoActual = estados.HERIDO
		animated_sprite_2d.modulate = Color(1,0,0.01,0.5)
		animated_sprite_2d.play("hurt")
		estadoActual = estados.INVECIBLE
		collision_layer = 32
		collision_mask = 4
		invincible_timer.start()
		
func finishedLevel(level, scoreA, scoreB):
	get_tree().paused = true
	$FinalLevel.nextlevel = level
	$FinalLevel.show()
	$FinalLevel.get_child(0).get_child(3).grab_focus()
	$FinalLevel.scorelvl(score, scoreA, scoreB)
	$FinalLevel.flechas_hielo = numflechas_hielo
	$FinalLevel.flechas_fuego = numflechas_fuego
	$FinalLevel.flechas_electro = numflechas_electro
	

func _on_invincible_timer_timeout() -> void:
	estadoActual = estados.NORMAL
	animated_sprite_2d.modulate = Color(1,1,1,1)
	collision_layer = 1
	collision_mask = 14
