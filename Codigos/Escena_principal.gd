extends Spatial

#export var posicion_dinosario_z = 0#es para ver la posicion del dinosaurio variable para prueba
#export var bloque_posicion_nueva = 0#muestra la posicion nueva del bloque variable para prueba

var muerto_controlador = false#determina de forma global si el jugador esta vivo o muerto

export(Array,PackedScene) var obstaculos #arreglo de escenas
export var bloqueTamanio = 66#determina el tamaña de cada bloque de suelo

export var punteroDeJuego = -7#donde esta ubicado el puntero
export var lugarSeguroDeGeneracion = 12#es para que se genere un nuevo suelo antes que el personaje llegue al puntero 
export var indice = 0#determina el indice para instanciar las escenas
var perdiste = false #esta variable dice cuando perdisto o no perdiste
var cantidad_de_instancias_obstaculos#variable para contar la cantidad de instancias

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()#genera una semilla aleatoria
	punteroDeJuego = -7#posicion inicial del puntero
	#print(obstaculos.size())#variable para prueba


func _process(delta):
	
	
	#print($dinosaruio.translation.z)#variable para prueba
	#posicion_dinosario_z = $dinosaruio.translation.z#variable para prueba
	
#---------esto esta relacionado con la vida y la muerte de personaje-----------------
	if muerto_controlador == false:#si el personaje no esta muerto
		$puntaje.text = "Puntaje = " + str(int($dinosaruio.translation.z))#esto en entero que se muestra por pantalla
	else:#sino
		if perdiste == false:#si perdiste es igual falso
			perdiste = true#perdiste es igual a verdero
			$puntaje.text += "\nTermino el juego \n Espere 2 segundos \n Presione Click para reiniciar \n Presione la pantalla para reiniciar"#agregamos este texto
			#$AnimationPlayer.stop()#detiene la animación del animation player
			$animaciones/AnimationTree.active = false
		if perdiste == true:#si perdiste
			$dinosaurio_particulas.visible = false#deja de ser visibles las particulas
			yield(get_tree().create_timer(2.0),"timeout")#detiene el flujo del codigo por un tiempo para evitar que inmediatamente luego de perder se reinicie la escena
			if Input.is_action_just_pressed("click_izquierdo") or Input.is_action_just_pressed("click_touch"):#si presionas click izquierdo
				get_tree().reload_current_scene()#reincia la escena
#------------------------------------------------------------------------------------------		

	
#------estp es para instanciar escenas------------------------------------------	
	while(muerto_controlador == false and punteroDeJuego < $dinosaruio.translation.z + lugarSeguroDeGeneracion):
		indice = randi() %obstaculos.size() #genera un numero aleatorio entre dependiendo la cantidad de objetos del arreglo	
		print(indice)
		
		#if(punteroDeJuego < 0):
			#indice = 5
		
		#if(punteroDeJuego > 0):#si el puntero de juego es mayor a 0
			#indice = randi() %obstaculos.size() -1#instancio con un número aleatorio pero evito el 5 ya que es la primer plataforma
		
		var sueloNuevo = obstaculos[indice].instance()#instancia la escena desde el packetScene con su indice
		$Obstaculos_instanciados.add_child(sueloNuevo)#agrega como hijo al nodo obstaculo_instanciado
		sueloNuevo.translation.z = punteroDeJuego + bloqueTamanio / 2#determina la posicion del nuevo bloque
		
		punteroDeJuego +=  bloqueTamanio#determina la ubicación del puntero
		
		#bloque_posicion_nueva = sueloNuevo.translation.z#variable para prueba
		$referencia_puntero.translation.z = punteroDeJuego#variable para prueba
		
		#print("posicion de suelo nuevo " , sueloNuevo.translation.z)#variable para prueba
		
		#print("posicion de puntero " , punteroDeJuego)#variable para prueba
		#print("esta muerto = " , muerto_controlador , "\n" )#variable para prueba
#----------------------------------------------------------------------------------------
	
#---------------------esto es para eliminarlas-------------------------
	cantidad_de_instancias_obstaculos = $Obstaculos_instanciados.get_child_count()#cantidad	
	if cantidad_de_instancias_obstaculos >= 3:#si hay más de 3 plataformas
		var suelo = $Obstaculos_instanciados.get_child(0)#busco el nodo más cercano osea el primero que se instancio
		suelo.queue_free()#eliminar ese nodo
