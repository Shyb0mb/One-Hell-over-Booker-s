extends Node2D
@export var gotoscene :PackedScene
@export var funnyBits :bool=false
@onready var anim: AnimationPlayer = $FortySix/Anim
@onready var fortysix: Sprite2D = $FortySix

func _input(_event: InputEvent) -> void:
	if Input.is_anything_pressed() and $Timer.is_stopped():
		get_tree().call_deferred("change_scene_to_packed",gotoscene)

func _on_sound_finished() -> void:
	await get_tree().create_timer(1).timeout
	anim.play("fadeout")
	await anim.animation_finished
	
	get_tree().call_deferred("change_scene_to_packed",gotoscene)
