import RealmSwift
import BrightFutures

class WorkoutStore {

    enum RealmError: ErrorType {
        case ReadError
        case WriteError
    }

    enum OnThread {
        case OnMain
        case OnBackground

        func thread() -> dispatch_queue_t {
            switch self {
            case .OnBackground:
                return fetchQueue
            default:
                return dispatch_get_main_queue()
            }
        }
    }

    static var sharedInstance = WorkoutStore()
    static let fetchQueue = dispatch_queue_create("com.flex.workoutstore", DISPATCH_QUEUE_SERIAL)

    private var mainThreadWorkoutModelsForIdentifier: [String: WorkoutModel] = [:]

    func allSnapshots() -> Future<[WorkoutSnapshot], RealmError> {
        let promise = Promise<[WorkoutSnapshot], RealmError>()
        dispatch_async(WorkoutStore.fetchQueue) {
            let realm = try! Realm()
            let workoutModels = realm.objects(WorkoutModel.self)
            let snapshots = workoutModels.map({ WorkoutSnapshot(workoutModel: $0) })
            promise.success(snapshots)
        }
        return promise.future
    }

    func fetchWorkouts(on thread: OnThread = .OnMain,
                  workoutWithIdentifier identifier: String) -> Future<WorkoutModel?, RealmError> {
        let promise = Promise<WorkoutModel?, RealmError>()
        dispatch_async(thread.thread()) {
            let realm = try! Realm()
            let workoutModels = realm.objects(WorkoutModel.self).filter("identifier = %@", identifier)
            promise.success(workoutModels.first)
        }
        return promise.future
    }

    func fetchWorkoutTemplates(on thread: OnThread = .OnMain,
                          workoutWithIdentifier identifier: String) -> Future<WorkoutTemplate?, RealmError> {
        let promise = Promise<WorkoutTemplate?, RealmError>()
        dispatch_async(thread.thread()) {
            let realm = try! Realm()
            let workoutTemplates = realm.objects(WorkoutTemplate.self).filter("identifier = %@", identifier)
            promise.success(workoutTemplates.first)
        }
        return promise.future
    }

    private func cache(workout: WorkoutRepresentable, `for` thread: OnThread) {
        switch thread {
        case .OnMain:
            guard let workout = workout as? WorkoutModel else { return }
            mainThreadWorkoutModelsForIdentifier.updateValue(workout, forKey: workout.identifier)
        default:
            return
        }
    }

}
