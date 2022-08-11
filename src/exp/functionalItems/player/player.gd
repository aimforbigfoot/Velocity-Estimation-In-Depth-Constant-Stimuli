extends Spatial

onready var headPointStationary := $headPointStationary
onready var breakText := $breakText
onready var t := $Tween
var infrontPos : Position3D
var behindPos : Position3D
var positionsFolder : Spatial

func _ready() -> void:
	Global.player = self
	t.connect("tween_all_completed",self,"tweenDone")
	positionsFolder = get_parent().get_node("positions")
	behindPos = get_parent().get_node("positions/playerPositions/behindPos")
	infrontPos = get_parent().get_node("positions/playerPositions/infrontPos")

func toggleBreak(toShow:bool) -> void:
	breakText.visible = toShow

func moveFoward() -> void:
	tweenPlayerNode(infrontPos.global_transform.origin)

func moveBackwards() -> void:
	tweenPlayerNode(behindPos.global_transform.origin)

func tweenPlayerNode(pos:Vector3) -> void:
	t.interpolate_property(
		self,
		"global_transform:origin",
		Helper.getNoYVector3(global_transform.origin),
		Helper.getNoYVector3(pos), 
		Helper.DURATIONOFSTIMULI,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
	t.start()

func tweenDone() -> void:
	positionsFolder.global_transform.origin = global_transform.origin

func getPlayerGlobalCamPosition() -> Vector3:
	return $OVRFirstPerson/ARVRCamera.global_transform.origin

func isCrosshairValidAtm() -> bool:
	return headPointStationary.isCrosshairValidAtm()

func throwCrosshairError() -> void:
	$errorText.show()
func hideCrosshairError() -> void:
	$errorText.hide()

func stopPlayer() -> void:
	t.stop_all()

func startChecking() -> void:
	headPointStationary.startChecking()
func stopChecking() -> void:
	headPointStationary.stopChecking()
