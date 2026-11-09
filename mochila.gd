extends Node

# Lleva la cuenta de los recursos que usted carga.
@export var capacidad = 5
@export var alcance = 0.0   # TODO hueco 1
var cuantos = 0
@onready var pj = get_parent()


func _physics_process(_delta):
	if Input.is_action_just_pressed("interactuar"):
		recoger()


func recoger():
	for r in get_tree().get_nodes_in_group("recursos"):
		if pj.global_position.distance_to(r.global_position) <= alcance:
			if cuantos >= capacidad:
				print("Mochila llena")
				return
			cuantos += 0   # TODO hueco 2
			print("Recursos: ", cuantos, " de ", capacidad)
			r.remove_from_group("recursos")
			r.queue_free()
			return


func vaciar():
	cuantos = 0
	print("Perdió lo que llevaba: Recursos: 0")


# Solo sirve mientras el hueco 4 de vidas.gd está sin llenar.
func vaciar_nada():
	print("Hueco 4 sin llenar: no pierde recursos")
