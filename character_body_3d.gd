extends CharacterBody3D

const JUMP_VELOCITY = 4.5

@export var move_speed: float = 1.0  # Velocidad de movimiento
@export var rotation_speed: float = 2.0  # Velocidad de rotación

@export var teclaAdelante: String  # Velocidad de movimiento
@export var teclaAtras: String 
@export var teclaIzquierda: String  # Velocidad de movimiento
@export var teclaDerecha: String
@export var teclaSaltar: String


func _process(delta: float) -> void:
	# Movimiento adelante y atrás
	var input_direction = Vector3.ZERO
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed(teclaSaltar) and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed(teclaAdelante):
		input_direction.z -= 1
	if Input.is_action_pressed(teclaAtras):
		input_direction.z += 1
	
	velocity = velocity * Vector3(0, 1, 0)
	# Mover el personaje en dirección local
	if input_direction != Vector3.ZERO:
		input_direction = input_direction.normalized() * move_speed
		velocity += transform.basis * input_direction
	
	
	# Rotación a la izquierda y derecha
	var rotation_direction = 0.0
	
	if Input.is_action_pressed(teclaDerecha):
		rotation_direction -= 1
	if Input.is_action_pressed(teclaIzquierda):
		rotation_direction += 1
	
	# Aplica la rotación alrededor del eje Y
	rotation.y += rotation_direction * rotation_speed * delta
	move_and_slide()
