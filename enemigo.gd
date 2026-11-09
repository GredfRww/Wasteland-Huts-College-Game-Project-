extends CharacterBody3D

# NIVEL 1: PATRULLAR. NIVEL 2: PERSEGUIR. NIVEL 3: QUITAR UNA VIDA.
enum Estado { PATRULLAR, PERSEGUIR }

@export var rapidez = 2.0
@export var rango_perseguir = 6.0
@export var rango_toque = 1.0
@export var espera_toque = 2.0
@export var ruta: Array[Vector3] = [Vector3(4, 0, 4), Vector3(-4, 0, 4)]

var estado = Estado.PATRULLAR
var indice = 0
var espera = 0.0
var jugador = null
@onready var anim = $Modelo/AnimationPlayer


func _ready():
	jugador = get_tree().get_first_node_in_group("jugador")


func _physics_process(delta):
	velocity += get_gravity() * delta
	espera = maxf(espera - delta, 0.0)
	var nuevo = decidir()
	if nuevo != estado:
		estado = nuevo
		print("Enemigo: ", Estado.keys()[estado])
	match estado:
		Estado.PATRULLAR:
			patrullar()
		Estado.PERSEGUIR:
			ir_a(jugador.global_position)
	tocar()
	move_and_slide()


func decidir():
	if espera > 0.001:
		return Estado.PATRULLAR
	if distancia_a(jugador.global_position) <= rango_perseguir:
		return Estado.PERSEGUIR
	return Estado.PATRULLAR


func patrullar():
	var destino = ruta[indice]
	if distancia_a(destino) < 0.2:
		var antes = indice
		indice = (indice + 1) % ruta.size()
		if indice != antes:
			print("Enemigo: voy al punto ", indice)
		return
	ir_a(destino)


func ir_a(destino):
	var hacia = destino - global_position
	hacia.y = 0.0
	var dir = hacia.normalized()
	velocity.x = dir.x * rapidez
	velocity.z = dir.z * rapidez
	if dir.length() > 0:
		basis = Basis.looking_at(dir)
	anim.play("walk")


func tocar():
	if espera > 0.001:
		return
	if distancia_a(jugador.global_position) <= rango_toque:
		print("Enemigo: te toqué")
		var vidas = jugador.get_node("Vidas")
		vidas.perder_vida()
		espera = espera_toque


func distancia_a(p):
	var o = global_position
	return Vector2(p.x - o.x, p.z - o.z).length()
