extends Spatial
class_name Helper

const DURATIONOFSTIMULI :float= 1.0

static func getNoYVector3(v:Vector3) -> Vector3:
	return Vector3(v.x, 0, v.z )

static func getRandomBallOrParticles() -> String:
	return Global.BALL if randf() < 0.5 else Global.PARTICLES

static func getNewVecWithOldY(oldvec:Vector3, newvec:Vector3 ) -> Vector3:
	return Vector3(newvec.x, oldvec.y, newvec.z   )
