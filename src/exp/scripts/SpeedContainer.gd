extends Node
class_name SpeedContainer
var maxTestsForConditionPerSpeed := 4 #mentally add 1 to it
#const SPEEDS_TO_TEST :Array=[0.10, 0.15, 0.23, 0.34, 0.52, 0.78, 1.17, 1.76, 2.65, 4.00]
#const SPEEDS_TO_TEST :Array=[0.3,0.48,0.77,1.23,1.96,3.13,5.00,8.00]
const SPEEDS_TO_TEST :Array=[0.2,0.34,0.57,0.97,1.65,2.79,4.72,8.00]
var arrOfResponses := [
	[], #1
	[], #2
	[], #3
	[], #4
	[], #5
	[], #6
	[], #7
	[], #8
]


func areAllArraysFull() -> bool:
	for arr in arrOfResponses:
		var array :Array=arr
		if array.size()-1 < maxTestsForConditionPerSpeed:
			return false
	print("THIS CONDITION IS DONE")
	return true


func updateInputSeperately(inputExpCond:ExpContainer, index:int=0) -> void:
	var speedToPutIn :float= inputExpCond.speedOfMovingVariable
	
	var moddedInputExpCond :ExpContainer= inputExpCond
	moddedInputExpCond.tag = index
	
	match speedToPutIn:
		0.2:
			arrOfResponses[0].append(inputExpCond)
		0.34:
			arrOfResponses[1].append(inputExpCond)
		0.57:
			arrOfResponses[2].append(inputExpCond)
		0.97:
			arrOfResponses[3].append(inputExpCond)
		1.65:
			arrOfResponses[4].append(inputExpCond)
		2.79:
			arrOfResponses[5].append(inputExpCond)
		4.72:
			arrOfResponses[6].append(inputExpCond)
		8.00:
			arrOfResponses[7].append(inputExpCond)
	
	var inputType :String= inputExpCond.whoWasFaster
	print("I GOT A ", inputType)
	print(speedToPutIn, " was the speed, and i said, ", inputType, " was faster")


func getSpeed() -> float:
	# we are gonna try getting a random unused or min speed
	var possibleIndecies := []
	var minSize := maxTestsForConditionPerSpeed+1
	
#	find the lowest size in a set of arrays
	for arr in arrOfResponses:
		var array :Array= arr 
		var sizeOfArr := array.size()
		if sizeOfArr < minSize:
			minSize = sizeOfArr
	
#	collect the indecies of those arrays
	if (maxTestsForConditionPerSpeed + 1) != minSize:
		var i := 0
		for arr in arrOfResponses:
			var array :Array= arr 
			if array.size() == minSize:
				possibleIndecies.append(i)
			i += 1
	if possibleIndecies:
		var randSpeedIndex :int= possibleIndecies[floor(randf()*possibleIndecies.size())]
		var randSpeed :float=SPEEDS_TO_TEST[randSpeedIndex]
	
		var res := "LEFTTTTTTTTTTTT"
		if randSpeed < 1.5: 
			res = "RIGHT"
	
		print(possibleIndecies.size()," is the possible number of arrays to pick from, i chose, ", randSpeed, " ", res)
		return randSpeed
	else:
		print("I LEGIT HAVE NO MORE SPEEDS TO GIVE U")
		return 0.0

	return 42.0 # this is error state 


#	match speedToPutIn:
#		0.30:
#			arrOfResponses[0].append(inputExpCond)
#		0.48:
#			arrOfResponses[1].append(inputExpCond)
#		0.77:
#			arrOfResponses[2].append(inputExpCond)
#		1.23:
#			arrOfResponses[3].append(inputExpCond)
#		1.96:
#			arrOfResponses[4].append(inputExpCond)
#		3.13:
#			arrOfResponses[5].append(inputExpCond)
#		5.00:
#			arrOfResponses[6].append(inputExpCond)
#		8.00:
#			arrOfResponses[7].append(inputExpCond)
