import Foundation
import RealmSwift

class ExerciseModel: Object {
    let liftingSets = List<LiftingSetModel>()
    let cardioSets = List<CardioSetModel>()
    dynamic var workoutIdentifier: String? = nil
    dynamic var name = ""
    dynamic var exerciseType: Int = 0
    dynamic var restTimeInSeconds: Int = 0
    dynamic var targetSets: Int = 1
    dynamic var setsCompleted: Int = 0
    dynamic var targetWeight: Float = 0
    dynamic var targetCardioDuration: Float = 0
    dynamic var repRangeLow = 0
    dynamic var repRangeHigh = 0
    dynamic var isCompleted = false

    var type: ExerciseType { return ExerciseType(rawValue: exerciseType) ?? .Lifting }
    var repRange: Range<Int> { return repRangeLow ... repRangeHigh }

    enum ExerciseType: Int {
        case Lifting = 0
        case Cardio = 1
    }

    override static func ignoredProperties() -> [String] {
        return ["type", "repRange"]
    }

    convenience init(name: String,
                     restTime: Int,
                     type: ExerciseType = .Lifting,
                     workoutIdentifier: String = "",
                     targetSets: Int = 0,
                     targetWeight: Float = 0.0,
                     targetCardioDuration: Float = 0.0,
                     repRangeLow: Int = 0,
                     repRangeHigh: Int = 0) {
        self.init()
        self.exerciseType = type.rawValue
        self.restTimeInSeconds = restTime
        self.workoutIdentifier = workoutIdentifier
        self.targetSets = targetSets
        self.targetWeight = targetWeight
        self.targetCardioDuration = targetCardioDuration
        self.repRangeLow = 0
        self.repRangeHigh = 0
    }

    func updateCompletionStatus() {
        isCompleted = setsCompleted >= targetSets
    }
}
