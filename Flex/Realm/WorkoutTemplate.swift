import Foundation
import RealmSwift

public class WorkoutTemplate: Object {
    let exercises = List<ExerciseModel>()
    dynamic var name = ""
    dynamic private(set) var identifier = NSUUID().UUIDString
    dynamic var createdAt = NSDate()

    func generateWorkout() -> WorkoutModel {
        return WorkoutModel(name: name,
                       exercises: exercises.map({ $0 }),
                       templateIdentifier: identifier)
    }

    override public static func primaryKey() -> String? {
        return "identifier"
    }
}

