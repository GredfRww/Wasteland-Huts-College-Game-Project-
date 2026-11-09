extends CharacterBody3D

# El personaje camina a 3 metros por segundo con WASD.
@export var speed = 3.0
@onready var anim = $Modelo/AnimationPlayer


func _physics_process(delta):
	velocity += get_gravity() * delta
	var teclas = Input.get_vector("move_left", "move_right",
		"move_up", "move_down")
	var direccion = Vector3(teclas.x, 0.0, teclas.y).normalized()
	velocity.x = direccion.x * speed
	velocity.z = direccion.z * speed
	if direccion.length() > 0:
		basis = Basis.looking_at(direccion)
		anim.play("walk")
	else:
		anim.play("idle")
	move_and_slide()
