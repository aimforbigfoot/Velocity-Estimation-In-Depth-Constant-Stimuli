extends Node
class_name ExpContainer

var isEmpty := true
var index : int 
var conditionToTest : int
var whoWentFirst : String
var whoWasFaster : String
var timePressed : int 
var xRot:float
var yRot:float
var zRot:float
var speedOfMovingVariable : float
var tag :int

func makeExp(_index:int, _conditionToTest:int, _whoWentFirst:String, _speedOfMovingVariable:float) -> void:
	index = _index
	conditionToTest = _conditionToTest
	whoWentFirst = _whoWentFirst
	speedOfMovingVariable = _speedOfMovingVariable
	isEmpty = false

func updateAsAnError() -> void:
	whoWasFaster = "ERROR"
	timePressed = OS.get_unix_time()

func setWhoWasFaster(_whoWasFaster:String) -> void:
	whoWasFaster = _whoWasFaster
	timePressed = OS.get_unix_time()

func recordHeadRotation(rot:Vector3) -> void:
	xRot = rot.x
	yRot = rot.y
	zRot = rot.z
	pass
