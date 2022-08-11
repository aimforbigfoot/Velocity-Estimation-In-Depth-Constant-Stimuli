extends Spatial


func _ready() -> void:
	global_transform.origin += Vector3( rand_range(-0.40,0.40), 0, rand_range(-0.8,0.8)  )
	rotation_degrees.y = rand_range(0,360)
	
