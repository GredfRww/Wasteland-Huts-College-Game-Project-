extends Node

# Lleva la cuenta de las vidas.
@export var vidas = 3
@onready var personaje = get_parent()
var choza = Vector3.ZERO


func _ready():
	choza = personaje.global_position
	print("Vidas: ", vidas)


func perder_vida():
	vidas -= 1
	print("Vidas: ", vidas)
	if vidas <= 0:
		print("Reaparece en la choza")
		personaje.global_position = choza
		vidas = 3
		print("Vidas: ", vidas)
		var mochila = personaje.get_node("Mochila")
		mochila.vaciar_nada()   # TODO hueco 4
