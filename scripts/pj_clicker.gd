extends Node3D
@onready var piedra: Node3D = $rocksB_desert
@onready var robot: Node3D = $"3DGodotRobot"
@onready var movimientoJugador = StaticData.charOpcs["teclas"][numero_de_jugador] 
@onready var teclaAccion= movimientoJugador["tecla_accion"]
@export var numero_de_jugador : int
var animacion
var height = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if numero_de_jugador < 2:
		if Input.is_action_just_pressed(teclaAccion):
			animacion = robot.get_node("AnimationPlayer")
			animacion.play("Kick")
			piedra.global_transform.basis.y *= Vector3(1, height, 1)
			height -= 0.1
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
