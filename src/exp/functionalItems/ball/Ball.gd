# MUST VIEW CODE IN EXPSCENE
extends Spatial

onready var td := $Tween
var ballCloseToPlayer : Position3D
var ballFarFromPlayer : Position3D
var ballCloseToPlayerButBallFar : Position3D
var ballFarFromPlayerButBallFar : Position3D
var ballPositionsFolder : Spatial

func _ready() -> void:
	Global.ball = self
	td.connect("tween_all_completed",self,"tweenDoneOnBall")
	ballCloseToPlayer = get_parent().get_node("positions/balPositions/ballCloseToPlayer")
	ballFarFromPlayer = get_parent().get_node("positions/balPositions/ballFarFromPlayer")
	ballCloseToPlayerButBallFar = get_parent().get_node("positions/balPositions/ballCloseToPlayerButBallFar")
	ballFarFromPlayerButBallFar = get_parent().get_node("positions/balPositions/ballFarFromPlayerButBallFar")
	ballPositionsFolder = get_parent().get_node("positions/balPositions")

func moveTowardPlayer() -> void:
	ballPositionsFolder.global_transform.origin.y = Global.player.getPlayerGlobalCamPosition().y
	global_transform.origin = ballFarFromPlayer.global_transform.origin 
	tweenBall(ballCloseToPlayer.global_transform.origin)

func moveBackwards() -> void:
	ballPositionsFolder.global_transform.origin.y = Global.player.getPlayerGlobalCamPosition().y
	global_transform.origin = ballCloseToPlayer.global_transform.origin 
	tweenBall(ballFarFromPlayer.global_transform.origin)

func moveTowardPlayerButPlayerMoveTowardsAsWell() -> void:
	ballPositionsFolder.global_transform.origin.y = Global.player.getPlayerGlobalCamPosition().y
	global_transform.origin = ballFarFromPlayerButBallFar.global_transform.origin 
	tweenBall(ballCloseToPlayerButBallFar.global_transform.origin)

func moveBackwardsButPlayerMoveTowardsAsWell() -> void:
	ballPositionsFolder.global_transform.origin.y = Global.player.getPlayerGlobalCamPosition().y
	global_transform.origin = ballCloseToPlayerButBallFar.global_transform.origin 
	tweenBall(ballFarFromPlayerButBallFar.global_transform.origin)


func tweenBall(pos:Vector3) -> void:
#	print(global_transform.origin, " ", pos)
	visible = true
	ballPositionsFolder.global_transform.origin.y = Global.player.getPlayerGlobalCamPosition().y
	td.interpolate_property(
		self,
		"global_transform:origin",
		(global_transform.origin),
		(pos), 
		Helper.DURATIONOFSTIMULI,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
	td.start()

func tweenDoneOnBall() -> void:
	visible = false

func hideBall() -> void:
	tweenDoneOnBall()
