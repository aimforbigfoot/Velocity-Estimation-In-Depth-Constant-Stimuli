extends Spatial

onready var displayParticlesTimer := $displayParticlesTimer
onready var particles := $Particles
onready var leftPos := $left
onready var rightPos := $right

func _ready() -> void:
	Global.particles = self
	displayParticlesTimer.connect("timeout",self,"completeParticles")

func startParticles(speed:float) -> void:
	visible = true
	global_transform.origin.y = Global.player.getPlayerGlobalCamPosition().y
	global_transform.origin.z = Global.player.global_transform.origin.z + 7
	choseRandomLeftOrRight()
	setParticlesSpeed(speed)
	displayParticlesTimer.start()


func choseRandomLeftOrRight() -> void:
	if randf() < 1.5: # IF YOU WANT PARTICLES TO BE LEFT AND RIGHT CHANGE TO 0.5
		particles.global_transform.origin = leftPos.global_transform.origin
		particles.rotation_degrees.z = 180
	else:
		particles.global_transform.origin = rightPos.global_transform.origin
		particles.rotation_degrees.z = 0


func completeParticles() -> void:
	visible = false

func hideParticles() -> void:
	completeParticles()

func setParticlesSpeed(speed:float) -> void:
	particles.speed_scale = speed


