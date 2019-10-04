extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_pressed("click_izquierdo"):
		get_tree().change_scene("res://Escenas/Escena_principal.tscn")
	if Input.is_action_pressed("click_touch"):
		get_tree().change_scene("res://Escenas/Escena_principal.tscn")
		
