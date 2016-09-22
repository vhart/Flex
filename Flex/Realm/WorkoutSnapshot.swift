import RealmSwift

public struct WorkoutSnapshot {

    let identifier: String
    let name: String
    let templateIdentifier: String?
    private(set) var startDate: NSDate?
    private(set) var isComplete: Bool

    init(workoutModel model: WorkoutModel) {
        self.identifier = model.identifier
        self.templateIdentifier = model.templateIdentifier
        self.name = model.name
        self.startDate = model.createdAt
        self.isComplete = model.isComplete
    }

    func workoutModel(completion: (WorkoutModel?) -> Void){
        WorkoutStore.sharedInstance.fetchWorkouts(workoutWithIdentifier: identifier).onSuccess { model in
                completion(model)
        }
        .onFailure { error in
            completion(nil)
        }
    }
}

