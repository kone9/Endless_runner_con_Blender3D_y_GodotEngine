extends KinematicBody

export var velocidad = 1
var movimiento = Vector3()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# func _physics_process(delta):#esta funcion se repite 60 veces por segundos y esta optimizada para físicas
# 	movimiento.y -= 1#esto representa la gravedad en un cuerpo kinematico
# 	movimiento.z = velocidad * delta #esto mueve en cada segundo el personaje en el eje z
	
# 	move_and_slide(movimiento)
# 	print(get_slide_count())


	
