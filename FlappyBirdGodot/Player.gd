extends KinematicBody2D


const UP = Vector2(0,-1)
const FLAP = 200
const MAXFALLSPEED = 200
const GRAVITY = 10
var score=0
var motion = Vector2()
var Wall = preload("res://WallNode.tscn")
func _ready():
	OS.open_midi_inputs( )
	
	# Une boucle qui liste et affiche tous les appareil MIDI connecté à l'ordinateur
	for current_midi_input in OS.get_connected_midi_inputs( ):
		print(current_midi_input)
	pass # Replace with function body.


func  _physics_process(delta):
	
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y =  MAXFALLSPEED  
	
	if Input.is_action_just_pressed("FLAP"):
		motion.y = -FLAP
		
	motion = move_and_slide(motion,UP)

	get_parent().get_parent().get_node("CanvasLayer/RichTextLabel").text = str(score)
	
func _input(event):
	if event is InputEventMIDI:
		
		traiter_evenement_midi(event)
		# afficher_note(event.pitch)

func traiter_evenement_midi(event_midi):
	if event_midi.message == MIDI_MESSAGE_NOTE_ON:
		print("NOTE_ON")
		# "Si la note de l'événement MIDI est 48"
		if event_midi.pitch == 48:
			activer_objet(48)
			
		# "Sinon si la note de l'événement MIDI est 50"
		elif event_midi.pitch == 50:
			activer_objet(50)
			print(event_midi.velocity);

	
func activer_objet(note):
	if note == 48:
		# $"Conteneur_Objet_A".effet_objet()
		motion.y = -FLAP
	if note == 50:
		$"Conteneur_Objet_B".effet_objet()

func Wall_reset():
	var Wall_instance = Wall.instance()
	Wall_instance.position = Vector2(1000, rand_range(100,400))
	get_parent().call_deferred("add_child",Wall_instance)
	
func _on_Resetter_body_entered(body):
	if body.name == "Walls":
		body.queue_free()
		Wall_reset()


func _on_Detect_area_entered(area):
	if area.name == "PointArea": 
		score = score + 1


func _on_Detect_body_entered(body):
	if body.name == "Walls":
		get_tree().reload_current_scene()

