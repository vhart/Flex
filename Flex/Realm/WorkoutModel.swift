import Foundation
import RealmSwift

protocol WorkoutRepresentable {
    var exercises: List<ExerciseModel> { get }
    var name: String { get set }
    var createdAt: NSDate { get }
    var identifier: String { get }
}

public class WorkoutModel: Object, WorkoutRepresentable {
    let exercises = List<ExerciseModel>()
    dynamic var templateIdentifier: String?
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

