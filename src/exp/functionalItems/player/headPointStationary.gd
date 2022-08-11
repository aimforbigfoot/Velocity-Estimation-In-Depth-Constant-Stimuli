extends Position3D

signal throwCrosshairError
signal throwCrossHairFixMessage

onready var cam : ARVRCamera 
onready var checkTimer : Timer = $checkIfNotInCircle
onready var circle := $Torus001
onready var headPoint : Position3D
onready var BLUE_MAT := preload("res://assets/blue/blue.tres")
onready var INVIS_MAT := preload("res://assets/blue/blueinvis.tres")
const constOffest := Vector3( 0, -0.492, 3.688)
const maxDistance : float = 0.1

var hasEmittedErrorSignal := false
var hasEmittedFixxedSignal := false

func startChecking() -> void:
	print("ruiniojsdiojsdfiosdfiosdiofiosdfiosdfiodiofidf")
	checkTimer.start()
func stopChecking() -> void:
	checkTimer.stop()

func _ready() -> void:
	headPoint = get_parent().get_node("OVRFirstPerson/ARVRCamera/headPoint")
	cam = get_parent().get_node("OVRFirstPerson/ARVRCamera")
	checkTimer.connect("timeout", self, "checkIfPlayerHeadNotInCircle")

func _physics_process(delta: float) -> void:
	global_transform.origin = constOffest + cam.global_transform.origin
#	var res := isCrosshairValidAtm()
#	if not res and not hasEmittedErrorSignal:
#		emit_signal("throwCrosshairError")
#		hasEmittedErrorSignal = true
#		hasEmittedFixxedSignal = false
#	if res and not hasEmittedFixxedSignal:
#		emit_signal("throwCrossHairFixMessage")
#		hasEmittedFixxedSignal = true

#CARRY FROM 

func checkIfPlayerHeadNotInCircle() -> void:
	var isValidAtm := isCrosshairValidAtm()
	if isValidAtm and not hasEmittedFixxedSignal:
		hasEmittedFixxedSignal = true
		hasEmittedErrorSignal = false
#		emit_signal("throwCrossHairFixMessage")
		circle.material_override = INVIS_MAT
		print("all good")
	elif not hasEmittedErrorSignal and not isValidAtm:
		hasEmittedFixxedSignal = false
		hasEmittedErrorSignal = true
#		emit_signal("throwCrosshairError")
		circle.material_override = BLUE_MAT
		print("OUTTTT")


func isCrosshairValidAtm() -> bool:
	if getDistanceFromMovingPoint() <= maxDistance:
		return true
	return false


func getDistanceFromMovingPoint() -> float:
	var v : float
	v = headPoint.global_transform.origin.distance_squared_to(global_transform.origin)
	return v
	pass

