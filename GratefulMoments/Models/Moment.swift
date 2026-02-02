import Foundation
import SwiftData

class Moment {
    var title: String
    var note: String
    var imageData: Data?
    var timestamp: Date

    init(title: String, note: String, imageData: Data? = nil, timestamp: Date = .now) {
        self.title = title
        self.note = note
        self.imageData = imageData
        self.timestamp = timestamp
    }
}
