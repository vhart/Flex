import RealmSwift
import BrightFutures

class WorkoutStore {

    enum RealmError: ErrorType {
        case ReadError
        case WriteError
    }

    static var sharedInstance = WorkoutStore()
    let fetchQueue = dispatch_queue_create("com.flex.workoutstore", DISPATCH_QUEUE_SERIAL)

    func allSnapshots() -> Future<[WorkoutSnapshot], RealmError> {
        let promise = Promise<[WorkoutSnapshot], RealmError>()
        dispatch_async(fetchQueue) {
            let realm = try! Realm()
            let workoutModels = realm.objects(WorkoutModel.self)
            let snapshots = workoutModels.map({ WorkoutSnapshot(workoutModel: $0) })
            promise.success(snapshots)
        }
        return promise.future
    }


}
