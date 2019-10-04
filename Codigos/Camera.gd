extends Camera

var personaje
var escena_principal

# Called when the node enters the scene tree for the first time.
func _ready():
	personaje = get_tree().get_nodes_in_group("dinosaruio")[0]#persnaje es igual al dinosaurio
	escena_principal = get_tree().get_nodes_in_group("Escena_principal")[0]#busco al nodo que esta en el grupo escena principal

func _process(delta):
	if escena_principal.muerto_controlador == false:#sino esta muerto
		translation.z = personaje.translation.z#la camara sigue en el eje Z al dinosaurio 
		get_tree().get_nodes_in_group("dinosaurio_particulas")[0].translation.z = get_tree().get_nodes_in_group("dinosaruio")[0].translation.z + 0.2#las particulas del suelo tienen la misma posicion que la del dinosaurio