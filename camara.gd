extends Camera3D

# La cámara va 12 metros arriba y 6 metros atrás del personaje.
@export var objetivo: Node3D
@export var distancia = Vector3(0, 12, 6)


func _ready():
	top_level = true
	look_at_from_position(objetivo.global_position + distancia,
		objetivo.global_position)


func _physics_process(_delta):
	global_position = objetivo.global_position + distancia
