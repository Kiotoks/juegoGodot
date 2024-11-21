extends Node3D
@onready var piedra: Node3D = $rocksB_desert
@onready var robot: Node3D = $"3DGodotRobot"
@export var numero_de_jugador : int = 0
var numero_de_mando = 0
@onready var movimientoJugador = StaticData.charOpcs["teclas"][numero_de_jugador] 
@onready var teclaAccion= movimientoJugador["tecla_accion"]
var animacion
var height = 2.5
var maxClicks = 50
var paso = height/(maxClicks)
var terminado = false
var levanto = true
var delay = 0

@onready var confeti: Node3D = $Node3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animacion = robot.get_node("AnimationPlayer")
	numero_de_mando = StaticData.controllers[numero_de_jugador]
	robot.cambiarColor(numero_de_jugador)
	pass # Replace with function body.
func festejar():
	animacion.play("Hurt")
	confeti.activar()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func patear():
	animacion.play("Kick")
	piedra.global_transform.basis.y.y = height
	if height > 0:
		height -= paso
		print(height)
	else:
		terminado = true

func _process(delta: float) -> void:
	if numero_de_jugador < 2 and not terminado:
		if Input.is_action_just_pressed(teclaAccion):
			patear()
	if Input.get_joy_name(numero_de_mando) and not terminado:
		if Input.is_joy_button_pressed(numero_de_mando, 7) and levanto:
			patear()
			levanto = false
		else:
			if delay > 0.2:
				levanto = true
				delay = 0
	delay += delta
	
