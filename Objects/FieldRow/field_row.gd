class_name FieldRow

extends Node2D


@export_group("References")


@export_group("Properties")
@export var hydration_limits = Vector2(0, 100)
@export var healthy_hydration_range = Vector2(25, 75)
@export var hydration_start_range = Vector2(25, 75)

var healthy : bool = true
var dead : bool = false


var hydration : float = 0 :
	get = get_hydration, set = set_hydration


func get_hydration() -> float:

	return hydration


func set_hydration(val) -> void:

	hydration = val

	healthy = hydration >= healthy_hydration_range.x and hydration <= healthy_hydration_range.y
	dead = hydration < hydration_limits.x or hydration > hydration_limits.y


func _enter_tree() -> void:

	hydration = Random.randf_range_vec2(healthy_hydration_range)
	pass


func _process(delta: float) -> void:

	#FIXME Print
	print(hydration)

	pass


func modify_hydration(modification) -> void:

	hydration += modification


func _on_points_timer_timeout() -> void:

	pass # Replace with function body.
