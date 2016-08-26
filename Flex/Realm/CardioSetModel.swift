import RealmSwift

class CardioSetModel: Object {
    dynamic var duration: Float = 0.0
    dynamic var distance: Float = 0.0
    dynamic var intensityType = 1
    
    var intensity: CardioIntensity {
        return CardioIntensity(rawValue: intensityType) ?? .Moderate
    }
    
    enum CardioIntensity: Int {
        case Low = 0
        case Moderate = 1
        case High = 2
    }

    override static func ignoredProperties() -> [String] {
        return ["intensity"]
    }
    
    convenience init(duration: Float,
                     distance: Float = 0.0,
                     intensity: CardioIntensity = .Moderate) {
        self.init()
        self.duration = duration
        self.distance = distance
        self.intensityType = intensity.rawValue
    }
}
