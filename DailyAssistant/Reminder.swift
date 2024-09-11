import Foundation

struct Reminder: Identifiable {
    var id = UUID()
    var title: String
    var date: Date
    var description: String
    var isActive: Bool
}
