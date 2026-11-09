extends Node3D

# Este personaje pide recursos. Usted se los entrega con E.
@export var pide = 5
@export var alcance = 2.0
var ya_gano = false


func _physics_process(_delta):
	if ya_gano or not Input.is_action_just_pressed("interactuar"):
		return
	var pj = get_tree().get_first_node_in_group("jugador")
	if global_position.distance_to(pj.global_position) > alcance:
		return
	var mochila = pj.get_node("Mochila")
	if mochila.cuantos >= 99:   # TODO hueco 3
		ya_gano = true
		print("Vecina: gracias, ya tengo todo. ¡Ganó!")
	else:
		print("Vecina: necesito ", pide, ". Usted trae ", mochila.cuantos)
