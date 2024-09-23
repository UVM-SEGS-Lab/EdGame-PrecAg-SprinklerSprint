class_name RainWeatherEffect

extends BaseWeatherEffect


@export_group("References")
@export var rain_particle_system : GPUParticles2D
@export var rain_audio_player : AudioFader
@export var rain_audio_options : Array[AudioStream]


@export_group("Properties")
@export var offset_from_field : Vector2 = Vector2(0, 0)
@export var x_bound_padding : float = 0

@export_group("Audio Properties")
@export var fade_in_time : float = 2
@export var fade_in_start_volume : float = -80
@export var fade_in_end_volume : float = -18



func _ready() -> void:

	super()

	var avg_pos := calculate_row_avg_pos()
	rain_particle_system.global_position = avg_pos + offset_from_field

	var process_material = rain_particle_system.process_material as ParticleProcessMaterial
	var extents = process_material.emission_box_extents
	var x_bounds = calculate_field_x_bounds()
	process_material.emission_box_extents = \
		Vector3((x_bounds.y - x_bounds.x) / 2.0 + x_bound_padding, extents.y, extents.z)

	rain_audio_player.stream = rain_audio_options.pick_random()
	rain_audio_player.start_fade(fade_in_time, fade_in_start_volume, fade_in_end_volume)
	rain_audio_player.play(randf_range(0, rain_audio_player.stream.get_length()))

	pass


func calculate_row_avg_pos() -> Vector2:

	var avg := Vector2(0, 0)

	for row in field.rows:
		avg += row.global_position

	avg /= field.rows.size()

	return avg


## Returns 0: Lower x bound, 1: Upper x bound
func calculate_field_x_bounds() -> Vector2:

	var bounds := Vector2(INF, -INF)

	for row in field.rows:

		if row.global_position.x < bounds.x:
			bounds.x = row.global_position.x

		if row.global_position.x > bounds.y:
			bounds.y = row.global_position.x

	return bounds

