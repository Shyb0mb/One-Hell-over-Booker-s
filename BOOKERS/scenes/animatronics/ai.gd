@abstract
extends Node
##Base abstract AI Class that handles an individual character.
##
##This class is [b]abstract[/b], meaning that AI scripts will have to define their own classes.
##I did this so other scripts can grab character-specific variables when necessary.
class_name AI

##The ID for the individual character.[br]
##Make sure that the ID is [b]UPPERCASE!!!!!!!![/b] and has [b]NO SPACES!!!!!!!![/b]
@export var character:StringName
##The AI Value that determines the aggressiveness of the character.[br]
##You know the deal. Each movement check rolls a random chance of 1-20, if the AI Value
##is greater or equal to the random chance they pass the movement check.
@export_range(0,20,1.0) var ai_value:int=0:
	set(value):
		ai_value = clamp(value,0,20)
##How long the time intervals are between each movement check, in seconds.
@export var move_time:float=5.0
##How fast the [member timer] increases. For example, [code]2.0[/code]
##makes the timer increase twice as fast.
@export var move_time_scale:float=1.0
##The actual timer for the movement checks.[br]
##This increases every frame by [member move_time_scale] until it reaches
##[member move_time], resetting and triggering the movement check.
var timer:float=0.0

func _ready() -> void:
	if ai_value == 0:
		set_process(false)

##Called when [member timer] "runs out." calls [method execute_movement] if the check is met.
func _movement_check() -> void:
	print("Movement check for ",character)
	if randi_range(1,20) <= ai_value:
		print(character," passed the movement check!")
	else:
		print(character," did not pass the movement check.")

##Called when [method _movement_check] succeeds or the individual is forced to move.
##This function needs to be overridden in extended classes for movement.
func execute_movement() -> void:
	pass

func _process(delta: float) -> void:
	if timer < move_time:
		timer += delta * move_time_scale
	else:
		timer = 0.0
		_movement_check()
