extends RigidBody

export var impulso : float = 12#variable que cambio desde el editor para determinar el impulso
var posicion = Vector3()#esto determina la posicion donde va a estar
var puede_saltar = false
export var velocidad : float = 5#determina la velocidad del dinosaurio

# Called when the node enters the scene tree for the first time.
func _ready():
	#velocidad = 5 #en un comienzo la velocidad va a ser 5
	pass

# func _physics_process(delta):
# 	# linear_velocity.z = velocidad#la velocidad lineal va a ser igual a la velocidad
# 	pass
	
func _on_Area_area_entered(area : Area):
	if area.is_in_group("obstaculo"):#si el area esta en el grupo obstaculo
		get_tree().get_nodes_in_group("sonido_fondo")[0].playing = false#activa sonido morir
		get_tree().get_nodes_in_group("morir")[0].playing = true#activa sonido morir
		get_tree().get_nodes_in_group("Escena_principal")[0].muerto_controlador = true#cambio la variable global desde el personaje para determinar que esta muerto
		queue_free()#elimino el dinosaurio o el objeto que tiene este script
	
	#esto es con el area
	if area.is_in_group("suelo_area"):#si colisiona con el suelo
		# if puede_saltar == false:
		linear_velocity.z = velocidad
		puede_saltar = true#puede saltar
		print(puede_saltar)
		get_tree().get_nodes_in_group("caer")[0].playing = true#activa sonido morir
		$AnimationTree["parameters/combinar/blend_amount"] = 0#cambia la animacion a correr
		get_tree().get_nodes_in_group("dinosaurio_particulas")[0].emitting = true#emite particulas en el piso
		get_tree().get_nodes_in_group("dinosaurio_particulas")[0].lifetime = 0.5#el nodo de las particulas es visible

func _input(event):
	if (Input.is_action_just_pressed("click_izquierdo") or Input.is_action_just_pressed("click_touch")):#si presiono click izquierdo
		if puede_saltar == true:
			puede_saltar = false#no puede saltar hasta que este en el suelo
			print(puede_saltar)
			posicion = translation
			#linear_velocity.y = 0
			apply_impulse(posicion,Vector3(0,impulso,1))#impulso hace que el personaje salte
			get_tree().get_nodes_in_group("saltar")[0].playing = true #activa sonido saltar
			get_tree().get_nodes_in_group("dinosaurio_particulas")[0].emitting = false#deja de emitir particulas en el peso
			get_tree().get_nodes_in_group("dinosaurio_particulas")[0].lifetime = 0.3#el nodo de las particulas no es visible
			$AnimationTree["parameters/combinar/blend_amount"] = 0.8#cambia la animacion a saltar

			
func _on_Timer_timeout():#si el tiempo termina
	velocidad += 1#aumento en 1 la velocidad
	
