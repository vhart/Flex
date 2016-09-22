import UIKit

class BasicExerciseCell: UICollectionViewCell {

    var exerciseModel: ExerciseModel? {
        didSet {
            guard let exercise = exerciseModel else { return }
            nameLabel.text = NSLocalizedString(exercise.name, comment: "")
            setsLabel.text = exercise.setsString()
            repRangeLabel.text = exercise.rangeString()
            restLabel.text = exercise.restString()

        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var setsLabel: UILabel!

    @IBOutlet weak var repRangeLabel: UILabel!

    @IBOutlet weak var restLabel: UILabel!
}

extension ExerciseModel {
    private func setsString() -> String {
        let setsText = targetSets == 1 ?
            NSLocalizedString("1 set", comment: "") :
            NSLocalizedString("\(targetSets) sets", comment: "")
        return setsText
    }

    private func rangeString() -> String? {
        guard repRangeHigh != repRangeLow else { return nil }
        return NSLocalizedString("\(repRangeLow) to \(repRangeHigh)", comment:  "")
    }

    private func restString() -> String? {
        var restTimeString: String?
        switch restTimeInSeconds {
        case 0 ... 60: restTimeString = "Rest: \(restTimeInSeconds) seconds"
        case _ where restTimeInSeconds > 60: "Rest: \(restTimeInSeconds / 60) min \(restTimeInSeconds % 60) seconds"
        default: restTimeString = nil
        }
        return restTimeString
    }
}
