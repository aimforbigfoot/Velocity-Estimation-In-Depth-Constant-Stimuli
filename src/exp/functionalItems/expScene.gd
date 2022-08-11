extends Spatial
export var isThrowingCrosshairErrors := true
# OBJECTS IN TREE_______________________________________________________________
# 													TIMERS
onready var start100 := $timers/start100
onready var finish1100 := $timers/finish1100
onready var start1200 := $timers/start1200
onready var finish2200 := $timers/finish2200
onready var break300 := $timers/break300
#													EXP RELATED NODES
onready var ball := $Ball
onready var particles := $Particles
onready var player := $player
onready var playerStationaryCrossHairHeadPoint := $player/headPointStationary
onready var playerMovingCrossHairHeadPoint := $player/OVRFirstPerson/ARVRCamera/headPoint
onready var endBubble := $player/endBubble
onready var startInstructions := $startInstructionsText
# CONSTANTS ____________________________________________________________________
const NUMTOTAKEABREAK := 50
const maxNumberOfTrials := 5
# ENUMS ________________________________________________________________________
enum CONDITION { 
	BALL_TOWARDS_PLAYER_STATIONARY,
	BALL_AWAY_PLAYER_STATIONARY,
	
	BALL_TOWARDS_PLAYER_FOWARD,
	BALL_AWAY_PLAYER_FOWARD,
	
	BALL_TOWARDS_PLAYER_BACKWARDS,
	BALL_AWAY_PLAYER_BACKWARDS,
}
enum INPUTS {LEFT=1, RIGHT=2, ERROR=3}
# VARIABLES_____________________________________________________________________
#													BOOLS
var hasStarted := false
var canPress := false
var isTryingToGetBackIntoATrial := false
var isDone := false
var isReadyToExit := false
var isOnBreak := false
#													ARRAYS
var expValues := []
#var conditionsToTest := [0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,]
#var conditionsToTest := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,00,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,00,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,00,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,00,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
#var conditionsToTest := [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5]
var conditionsToTest := [4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,4,5,3,2,1,0,]
var arrOfConditions := []
var arrOfDoneConditions := [false,false,false,false,false,false,]
#													INTS
var experimentIndex : int = 0
var globalExperimentCondition : int = 0
#													SPEED CONTAINERS
var condition0SpeedContainer := SpeedContainer.new()
var condition1SpeedContainer := SpeedContainer.new()
var condition2SpeedContainer := SpeedContainer.new()
var condition3SpeedContainer := SpeedContainer.new()
var condition4SpeedContainer := SpeedContainer.new()
var condition5SpeedContainer := SpeedContainer.new()
#													OBJECTS
var globalExpContainer : ExpContainer

# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------

# EXPERIMENT COROUTINES---------------------------------------------------------


func _ready() -> void:
	start100.connect("timeout",self,"start100Timeout")
	finish1100.connect("timeout",self,"finish1100Timeout")
	start1200.connect("timeout",self,"start1200Timeout")
	finish2200.connect("timeout",self,"finish2200Timeout")
	break300.connect("timeout",self,"break300Timeout")
	ball.hideBall()
	particles.hideParticles()
	startInstructions.show()
	playerStationaryCrossHairHeadPoint.connect("throwCrossHairFixMessage",self,"crossHairFixed")
	playerStationaryCrossHairHeadPoint.connect("throwCrosshairError",self,"crossHairBroken")
	conditionsToTest.shuffle()
	arrOfConditions = [ 
		condition0SpeedContainer,
		condition1SpeedContainer,
		condition2SpeedContainer,
		condition3SpeedContainer,
		condition4SpeedContainer,
		condition5SpeedContainer
	]


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("space"):
		if not hasStarted:
			hasStarted = true
			startATest(getConditionToTest())
			startInstructions.queue_free()


	if Input.is_action_just_pressed("esc") and not isDone:
		saveEverythingToCSV()
		isDone = true
		print("yes")
	elif Input.is_action_just_pressed("esc") and isDone and not isReadyToExit:
		endExperiment()
	elif Input.is_action_just_pressed("esc") and isReadyToExit:
		get_tree().change_scene("res://src/end/endScene.tscn")


	if hasStarted and canPress:
#		var expCondition :ExpContainer= expValues[experimentIndex-modifer]
		
		if Input.is_action_just_pressed("left"): # ball - should speed up || Particles faster
#			if isTryingToGetBackIntoATrial:
#				if player.isCrosshairValidAtm(): 
#					startATest(getConditionToTest())
#					isTryingToGetBackIntoATrial = false
#				return
			if true:
				player.hideCrosshairError()
				getCurrentExpContainer().recordHeadRotation($player/OVRFirstPerson/ARVRCamera.rotation_degrees)
				isTryingToGetBackIntoATrial = false
				canPress = false
				globalExpContainer.setWhoWasFaster(Global.PARTICLES)
			match globalExpContainer.conditionToTest:
				CONDITION.BALL_TOWARDS_PLAYER_STATIONARY:
					condition0SpeedContainer.updateInputSeperately(getCurrentExpContainer(), experimentIndex)
				CONDITION.BALL_AWAY_PLAYER_STATIONARY:
					condition1SpeedContainer.updateInputSeperately(getCurrentExpContainer(), experimentIndex)
				CONDITION.BALL_TOWARDS_PLAYER_FOWARD:
					condition2SpeedContainer.updateInputSeperately(getCurrentExpContainer(), experimentIndex)
				CONDITION.BALL_AWAY_PLAYER_FOWARD:
					condition3SpeedContainer.updateInputSeperately(getCurrentExpContainer(), experimentIndex)
				CONDITION.BALL_TOWARDS_PLAYER_BACKWARDS:
					condition4SpeedContainer.updateInputSeperately(getCurrentExpContainer(), experimentIndex)
				CONDITION.BALL_AWAY_PLAYER_BACKWARDS:
					condition5SpeedContainer.updateInputSeperately(getCurrentExpContainer(), experimentIndex)
			print( globalExpContainer.speedOfMovingVariable, " was considered to be fast, for condtion ", globalExpContainer.whoWasFaster  )
			break300.start()
			
		if Input.is_action_just_pressed("right"): # particles - should slow down || Ball is faster
#			if isTryingToGetBackIntoATrial:
#				if player.isCrosshairValidAtm():
#					startATest(getConditionToTest())
#					isTryingToGetBackIntoATrial = false
#				return
			if true:
				player.hideCrosshairError()
				getCurrentExpContainer().recordHeadRotation($player/OVRFirstPerson/ARVRCamera.rotation_degrees)
				isTryingToGetBackIntoATrial = false
				canPress = false
				globalExpContainer.setWhoWasFaster(Global.BALL)
			match globalExpContainer.conditionToTest:
				CONDITION.BALL_TOWARDS_PLAYER_STATIONARY:
					condition0SpeedContainer.updateInputSeperately(getCurrentExpContainer(), experimentIndex)
				CONDITION.BALL_AWAY_PLAYER_STATIONARY:
					condition1SpeedContainer.updateInputSeperately(getCurrentExpContainer(), experimentIndex)
				CONDITION.BALL_TOWARDS_PLAYER_FOWARD:
					condition2SpeedContainer.updateInputSeperately(getCurrentExpContainer(), experimentIndex)
				CONDITION.BALL_AWAY_PLAYER_FOWARD:
					condition3SpeedContainer.updateInputSeperately(getCurrentExpContainer(), experimentIndex)
				CONDITION.BALL_TOWARDS_PLAYER_BACKWARDS:
					condition4SpeedContainer.updateInputSeperately(getCurrentExpContainer(), experimentIndex)
				CONDITION.BALL_AWAY_PLAYER_BACKWARDS:
					condition5SpeedContainer.updateInputSeperately(getCurrentExpContainer(), experimentIndex)
			print( globalExpContainer.speedOfMovingVariable, " was considered to be slow, for condtion ", globalExpContainer.whoWasFaster  )
			break300.start()
		return
	
	
	print("I never got run")
	if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
		print("yes I disabled your BREAK SDIFODSIFOIOSFDIODSFOISDFIOSDFIODFIOFDOIj")
		startATest(getConditionToTest(), true)
		canPress = true
		player.startChecking() # CROSS HAIR RELATED
		player.toggleBreak(false)
		isOnBreak = false
		ball.hide()
		particles.hide()



func crossHairFixed() -> void:
	player.hideCrosshairError()
	canPress = true
	var latestExpConditionBlock : ExpContainer = expValues[experimentIndex-1]
	startATest( latestExpConditionBlock.conditionToTest )
func crossHairBroken() -> void:
	player.throwCrosshairError()
	var latestExpConditionBlock : ExpContainer = expValues[experimentIndex-1]
	latestExpConditionBlock.updateAsAnError()
	canPress = false


func startATest(conditionToTest:int, override:bool=false) -> void:
	randomize()
	print("\n")
	if conditionToTest != 99:
		if (experimentIndex+1) % NUMTOTAKEABREAK != 0 or override:
			if true: #player.isCrosshairValidAtm() or 
				startTimers()
				player.startChecking() # CROSS HAIR RELATED
				experimentIndex += 1
				canPress = true
				
				var randomFirstString = Helper.getRandomBallOrParticles()
				var container := ExpContainer.new()
				
				match conditionToTest:
					CONDITION.BALL_TOWARDS_PLAYER_STATIONARY:
						var condition0Speed :float= condition0SpeedContainer.getSpeed()
						container.makeExp(experimentIndex, conditionToTest, randomFirstString, condition0Speed)
					CONDITION.BALL_AWAY_PLAYER_STATIONARY:
						var condition1Speed :float= condition1SpeedContainer.getSpeed()
						container.makeExp(experimentIndex, conditionToTest, randomFirstString, condition1Speed)

					CONDITION.BALL_TOWARDS_PLAYER_FOWARD:
						var condition2Speed :float= condition2SpeedContainer.getSpeed()
						container.makeExp(experimentIndex, conditionToTest, randomFirstString, condition2Speed)
					CONDITION.BALL_AWAY_PLAYER_FOWARD:
						var condition3Speed :float= condition3SpeedContainer.getSpeed()
						container.makeExp(experimentIndex, conditionToTest, randomFirstString, condition3Speed)

					CONDITION.BALL_TOWARDS_PLAYER_BACKWARDS:
						var condition4Speed :float= condition4SpeedContainer.getSpeed()
						container.makeExp(experimentIndex, conditionToTest, randomFirstString, condition4Speed)
					CONDITION.BALL_AWAY_PLAYER_BACKWARDS:
						var condition5Speed :float= condition5SpeedContainer.getSpeed()
						container.makeExp(experimentIndex, conditionToTest, randomFirstString, condition5Speed)
				expValues.append(container)
				globalExpContainer = container
				
#				printExpValues()
			else:
				if isThrowingCrosshairErrors:
					isTryingToGetBackIntoATrial = true
					player.throwCrosshairError()
		else:
			isOnBreak = true
			print("yes u did just take a break")
			player.stopChecking()
			player.toggleBreak(true)
			pass
	else:
		endExperiment()
		pass

# TIMER RELATED EVENTS ---------------------------------------------------------
func start100Timeout() -> void: # STARTING THE FIRST CONDITION HERE ------------
	var whoWasFirst = getCurrentConditionsFirstVar()
	var expCondition = getCurrentConditionValue()
	
	if whoWasFirst == Global.BALL:
		match expCondition:
			0:
				moveBallAccordingToExp0()
			1:
				moveBallAccordingToExp1()
			2:
				moveBallAccordingToExp2()
			3:
				moveBallAccordingToExp3()
			4:
				moveBallAccordingToExp4()
			5:
				moveBallAccordingToExp5()
			
	elif whoWasFirst == Global.PARTICLES:
		match expCondition:
			0:
				startParticles(globalExpContainer.speedOfMovingVariable)
			1:
				startParticles(globalExpContainer.speedOfMovingVariable)
			2:
				startParticles(globalExpContainer.speedOfMovingVariable)
			3:
				startParticles(globalExpContainer.speedOfMovingVariable)
			4:
				startParticles(globalExpContainer.speedOfMovingVariable)
			5:
				startParticles(globalExpContainer.speedOfMovingVariable)

func finish1100Timeout() -> void: # HIDE THAT FIRST CONDITION PRONTO -----------
#	print("gonna take a small break")
	pass
# THERE IS A 100 MS DELAY HERE YOU DUMB DUMB
func start1200Timeout() -> void: # START THAT NEXT CONDITION PROTNO ------------
	var whoWasFirst = getCurrentConditionsFirstVar()
	var expCondition = getCurrentConditionValue()
	
	if whoWasFirst == Global.PARTICLES: 
		match expCondition:
			0:
				moveBallAccordingToExp0()
			1:
				moveBallAccordingToExp1()
			2:
				moveBallAccordingToExp2()
			3:
				moveBallAccordingToExp3()
			4:
				moveBallAccordingToExp4()
			5:
				moveBallAccordingToExp5()
			
	elif whoWasFirst == Global.BALL:
		match expCondition:
			0:
				startParticles(globalExpContainer.speedOfMovingVariable)
			1:
				startParticles(globalExpContainer.speedOfMovingVariable)
			2:
				startParticles(globalExpContainer.speedOfMovingVariable)
			3:
				startParticles(globalExpContainer.speedOfMovingVariable)
			4:
				startParticles(globalExpContainer.speedOfMovingVariable)
			5:
				startParticles(globalExpContainer.speedOfMovingVariable)

func finish2200Timeout() -> void: # HIDE THAT LAST CONDITION PRONTO ------------
	canPress = true

func break300Timeout() -> void:
	startATest(getConditionToTest())




func moveBallAccordingToExp0() -> void: # Ball Towards Player
	ball.moveTowardPlayer()
func moveBallAccordingToExp1() -> void:
	ball.moveBackwards()
func moveBallAccordingToExp2() -> void:
	ball.moveTowardPlayerButPlayerMoveTowardsAsWell()
	player.moveFoward()
func moveBallAccordingToExp3() -> void:
	ball.moveBackwardsButPlayerMoveTowardsAsWell()
	player.moveFoward()
func moveBallAccordingToExp4() -> void:
	ball.moveTowardPlayer()
	player.moveBackwards()
func moveBallAccordingToExp5() -> void:
	ball.moveBackwards()
	player.moveBackwards()

func startParticles(speed:float) -> void:
	particles.startParticles(speed)


# HELPING FUNTIONS--------------------------------------------------------------
func updateStatusOfAllConditions() -> void:
	var i := 0
	for cond in arrOfConditions:
		var speedcontainer : SpeedContainer = cond
		if speedcontainer.areAllArraysFull():
			arrOfDoneConditions[i] = true
		i += 1
#	print(arrOfDoneConditions)


func startTimers() -> void:
	start100.start()
	finish1100.start()
	start1200.start()
	finish2200.start()

func printExpValues() -> void:
	for condition in arrOfConditions:
		var cond :SpeedContainer=condition
		print(cond.arrOfResponses)

func getConditionToTest() -> int:
	updateStatusOfAllConditions()

	if experimentIndex  <  conditionsToTest.size():
		return int(conditionsToTest[ experimentIndex ])
	else:
		var possibleConditions := []
		
		for i in arrOfDoneConditions.size():
			if arrOfDoneConditions[i] != true:
				possibleConditions.append(i)
		
		print(possibleConditions)
		if possibleConditions:
			var possibleConditionsIndex := floor( randf() * possibleConditions.size() )
			var numChosen :int= possibleConditions[ possibleConditionsIndex ]
			globalExperimentCondition = numChosen
			return numChosen
		else:
			endExperiment()
	return 99

func getCurrentConditionsFirstVar() -> String:
	var t :ExpContainer =getCurrentExpContainer()
	return t.whoWentFirst
func getCurrentConditionSpeed() -> float:
	var t :ExpContainer =getCurrentExpContainer()
	return t.speedOfMovingVariable
func getCurrentConditionValue() -> int:
	var t :ExpContainer =getCurrentExpContainer()
	return t.conditionToTest

func getCurrentExpContainer() -> ExpContainer:
	return expValues[ expValues.size()-1 ]





func saveEverythingToCSV() -> void:
	var fileName := "velocityEstimationInDepthSave"
	var file := File.new()

	if OS.is_debug_build():
		file.open("user://"+ fileName +".csv", File.WRITE)
	else:
		file.open("res://"+fileName+"_"+str(OS.get_unix_time())+".csv", File.WRITE)
	
	var stringToWrite := """INDEX,CONDITION,WENT_FIRST,JUDGED_FASTER,TIME_PRESSED,SPEED_PART,X_ROTATION_OF_HEAD,Y_ROTATION_OF_HEAD,Z_ROTATION_OF_HEAD\n"""
	
	var arrOfConditionsFixed := [
		condition0SpeedContainer,
		condition1SpeedContainer,
		condition2SpeedContainer,
		condition3SpeedContainer,
		condition4SpeedContainer,
		condition5SpeedContainer
	]
	
	for cond in arrOfConditionsFixed:
		var speedcontainer : SpeedContainer = cond
		for arr in speedcontainer.arrOfResponses:
			for block in arr:
				var expcont : ExpContainer = block
				
				var convertedWhoWentFirst:int=0
				if expcont.whoWentFirst == "BALL":
					convertedWhoWentFirst = 0
				else:
					convertedWhoWentFirst = 1 # 1 is particles and comes when u press left
				
				var resultToSay := "SLOW"
				
				var convertedWhoWentFaster:int=0
				if expcont.whoWasFaster == "BALL":
					convertedWhoWentFaster = 0
				else:
					convertedWhoWentFaster = 1 # 0 is ball and comes when u press right
					resultToSay = "FAST"
				
				
				
#				var lineToAdd := (str(expcont.index)+","+str(expcont.conditionToTest)+","+str(convertedWhoWentFirst)+","+str(convertedWhoWentFaster)+","+str(expcont.timePressed)+","+str(expcont.speedOfMovingVariable)+","+str(expcont.xRot)+","+str(expcont.yRot)+","+str(expcont.zRot)+","+str(expcont.tag)+"\n")
				var lineToAdd := (str(expcont.index)+","+str(expcont.conditionToTest)+","+str(convertedWhoWentFirst)+","+str(convertedWhoWentFaster)+","+str(expcont.timePressed)+","+str(expcont.speedOfMovingVariable)+","+str(expcont.xRot)+","+str(expcont.yRot)+","+str(expcont.zRot)+"\n")
				print(lineToAdd)
				stringToWrite += lineToAdd
			stringToWrite += "\n"
		stringToWrite+="\n\n"
#	was working on the saving of file
#	for obj in expValues:
#		var node :ExpContainer=obj
#		print(node.speedOfMovingVariable)
#		var overalString := node.index
	file.store_string(stringToWrite)
	
	
	file.close()


func endExperiment() -> void:
	endBubble.show()
	player.stopPlayer()
	playerStationaryCrossHairHeadPoint.scale = Vector3.ZERO
	playerMovingCrossHairHeadPoint.scale = Vector3.ZERO
	get_parent().get_node("props").hide()
	$player/errorText.scale = Vector3.ZERO
	saveEverythingToCSV()
	ball.scale = Vector3.ZERO
	particles.scale = Vector3.ZERO
	ball.hide()
	particles.hide()
	isReadyToExit = true
	
	









