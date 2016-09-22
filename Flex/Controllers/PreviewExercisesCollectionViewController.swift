import BrightFutures
import RealmSwift

class PreviewExercisesCollectionViewController: UICollectionViewController {

    enum PreviewSection {
        case WorkoutTemplates
        case Workouts
    }

    class func fromStoryboard(withIdentifier identifier: String, forSectionType type: PreviewSection) -> PreviewExercisesCollectionViewController {
        let previewExerciseController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewControllerWithIdentifier("\(PreviewExercisesCollectionViewController.self)") as! PreviewExercisesCollectionViewController
        previewExerciseController.sectionType = type
        previewExerciseController.workoutIdentifier = identifier
        return previewExerciseController
    }

    private(set) var sectionType: PreviewSection!
    private(set) var workoutIdentifier: String! {
        didSet {
            guard let _ = oldValue else { return }
            fetch()
        }
    }
    private(set) var workoutPlan: WorkoutRepresentable? {
        didSet {
            collectionView?.reloadData()
        }
    }

    private let cellReuseIdentifier = "BasicExerciseCell"

    override func viewDidLoad() {
        fetch()
    }


    //MARK: Private functions

    private func fetch() {
        guard let sectionType = sectionType,
              identifier = workoutIdentifier else { return }

        switch sectionType {
        case .WorkoutTemplates:
            WorkoutStore.sharedInstance.fetchWorkoutTemplates(workoutWithIdentifier: identifier)
                .onSuccess(callback: { [weak self] template in
                     self?.workoutPlan = template
                })
        case .Workouts:
            WorkoutStore.sharedInstance.fetchWorkouts(workoutWithIdentifier: identifier)
                .onSuccess(callback: { [weak self] workout in
                    self?.workoutPlan = workout
                })
        }
    }
}

extension PreviewExercisesCollectionViewController {

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workoutPlan?.exercises.count ?? 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! BasicExerciseCell
        cell.exerciseModel = workoutPlan?.exercises[indexPath.row]
        return cell
    }
}
