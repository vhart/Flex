import Foundation
import RealmSwift

public class WorkoutModel: Object {
    let exercises = List<ExerciseModel>()
    dynamic var templateIdentifier = ""
    dynamic var name = ""
    dynamic private(set) var identifier = NSUUID().UUIDString
    dynamic var createdAt = NSDate()
    dynamic var isComplete = false

    convenience init(name: String,
                     exercises: [ExerciseModel]? = nil,
                     templateIdentifier: String = "") {
        self.init()
        self.name = name
        self.templateIdentifier = templateIdentifier
        if let exercises = exercises {
            for exercise in exercises {
                self.exercises.append(exercise)
            }
        }
    }

    override public static func primaryKey() -> String? {
        return "identifier"
    }

    func updateCompletionStatus() {
        for exercise in exercises {
            if exercise.isCompleted == false {
                isComplete = false
            }
        }
        isComplete = true
    }
}

