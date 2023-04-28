extends Node2D

func _ready():
	OS.open_midi_inputs( )
	for current_midi_input in OS.get_connected_midi_inputs( ):
		print(current_midi_input)
	$ScoreLabel.text="YOUR SCORE : "+str(Globalvariable.globalScore)

func _input(event):
	if event is InputEventMIDI:
		
		traiter_evenement_midi(event)
		# afficher_note(event.pitch)
		
func traiter_evenement_midi(event_midi):
	if event_midi.message == MIDI_MESSAGE_NOTE_ON:
		print("NOTE_ON")
		# "Si la note de l'événement MIDI est 48"
		if event_midi.pitch == 48:
			_on_Button_pressed()
			
		# "Sinon si la note de l'événement MIDI est 50"
		elif event_midi.pitch == 50:
			_on_Button_pressed()


func _on_Button_pressed():
	get_tree().change_scene("res://World.tscn")
	Globalvariable.globalScore=0
	
