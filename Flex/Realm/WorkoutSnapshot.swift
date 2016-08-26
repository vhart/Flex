import RealmSwift

public struct WorkoutSnapshot {

    let identifier: String
    let name: String
    private(set) var startDate: NSDate?
    private(set) var isComplete: Bool

    init(workoutModel model: WorkoutModel) {
        self.identifier = model.identifier
        self.name = model.name
        self.startDate = model.createdAt
        self.isComplete = model.isComplete
    }
}

