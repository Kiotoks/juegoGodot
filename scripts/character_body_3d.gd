extends CharacterBody3D

const JUMP_VELOCITY = 4.5

@onready var modelo3D: Node3D = $"3DGodotRobot"

@export var numero_de_jugador = 0 

@onready var movimientoJugador = StaticData.charOpcs["teclas"][numero_de_jugador] 

@onready var teclaAdelante = movimientoJugador["tecla_adelante"]
@onready var teclaAtras = movimientoJugador["tecla_atras"]
@onready var teclaIzquierda = movimientoJugador["tecla_izquierda"]
@onready var teclaDerecha = movimientoJugador["tecla_derecha"]
@onready var teclaSaltar = movimientoJugador["tecla_saltar"]
@onready var teclaAccion= movimientoJugador["tecla_accion"]

var animacion
var en_ataque = false

 # Velocidad de movimiento

@export var move_speed = 1.0  # Velocidad de movimiento
@export var rotation_speed = 5.0  # Velocidad de rotación
@export var force_strength = 10.0  # Fuerza aplicada al personaje en frente

# Nodo RayCast3D para detectar al personaje en frente
@export var raycast : RayCast3D

func _ready():
	# Activa el raycast para que detecte objetos
	raycast.enabled = true
	if modelo3D:
		animacion = modelo3D.get_node("AnimationPlayer")
		modelo3D.cambiarColor(numero_de_jugador)
		if animacion:
			animacion.connect("animation_finished", _on_animation_finished)

func _process(delta: float) -> void:
	# Movimiento adelante y atrás
	var input_direction = Vector3.ZERO
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Salto
	if Input.is_action_just_pressed(teclaSaltar) and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Detecta las teclas de movimiento para determinar la dirección
	if Input.is_action_pressed(teclaAdelante):
		input_direction.x -= 1
	if Input.is_action_pressed(teclaAtras):
		input_direction.x += 1
	if Input.is_action_pressed(teclaIzquierda):
		input_direction.z += 1
	if Input.is_action_pressed(teclaDerecha):
		input_direction.z -= 1
	
	 # Mantener solo la componente vertical

	# Mover el personaje en dirección global y calcular la dirección de rotación'
	if input_direction != Vector3.ZERO:
		input_direction = input_direction.normalized() * move_speed
		velocity.x = input_direction.x
		velocity.z = input_direction.z
		if not en_ataque and is_on_floor():
			animacion.play("Run")

		# Calcula el ángulo en el plano XZ para que el personaje apunte en la dirección de movimiento
		var target_rotation_y = atan2(-input_direction.x, -input_direction.z)
		rotation.y = lerp_angle(rotation.y, target_rotation_y, rotation_speed * delta)
	else:
		velocity *= Vector3(0.9, 1, 0.9)
		if not en_ataque and is_on_floor():
			animacion.play("Idle")
	
	if not is_on_floor() and not en_ataque:
		animacion.play("Jump")
	
	move_and_slide()
	
	# Aplica fuerza al personaje en frente cuando se toca la tecla de acción
	if Input.is_action_just_pressed(teclaAccion):
		en_ataque = true
		animacion.play("Attack1")
		aplicar_fuerza_a_personaje_en_frente()

func aplicar_fuerza_a_personaje_en_frente():
	if raycast.is_colliding():
		var personaje_en_frente = raycast.get_collider()
		if personaje_en_frente and personaje_en_frente is CharacterBody3D:
			var force_direction = -transform.basis.z.normalized()
			force_direction += Vector3(0, 0.3, 0)
			personaje_en_frente.velocity += force_direction * force_strength
			
func _on_animation_finished(anim_name):
	if anim_name == "Attack1":
		en_ataque = false  # Salir del estado de ataque
		
func set_numero_jugador( num: int):
	if num >= 0 and num <4:
		numero_de_jugador = num;

func set_coords(x, z):
	transform.origin.x = x
	transform.origin.z = z
	
