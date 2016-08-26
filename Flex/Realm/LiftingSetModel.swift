import  RealmSwift

class LiftingSetModel: Object {
    dynamic var targetWeight: Float = 0.0
    dynamic var weightPerformed: Float = 0.0
    dynamic var reps = 0
    dynamic var setType = 0
    dynamic var repRangeLow = 0
    dynamic var repRangeHigh = 0
    dynamic var succeeded = false
    
    var type: SetType { return SetType(rawValue: setType) ?? .Working }
    
    enum SetType: Int {
        case Working = 0
        case Warmup = 1
    }
    
    override static func ignoredProperties() -> [String] {
        return ["type"]
    }

    convenience init(weight: Float,
                     reps: Int,
                     targetWeight: Float = 0.0,
                     repRangeLow: Int = 0,
                     repRangeHigh: Int = 0,
                     setNumber: Int = 0,
                     setType: SetType = .Working) {
        self.init()
        self.weightPerformed = weight
        self.reps = reps
        self.targetWeight = targetWeight
        self.repRangeLow = repRangeLow
        self.repRangeHigh = repRangeHigh
        self.setType = setType.rawValue
    }
    
    func updateSuccess() {
        guard (targetWeight > 0.0 || repRangeHigh > 0) && type != .Warmup
            else {
                succeeded = true
                return
        }

        var hasSucceeded = false

        if (repRangeLow...repRangeHigh ~= reps || reps > repRangeHigh) {
            hasSucceeded = true
        }

        if targetWeight > 0.0 && weightPerformed < targetWeight {
            hasSucceeded = false
        }

        succeeded = hasSucceeded
    }
}