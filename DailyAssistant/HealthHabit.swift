import Foundation

struct HealthHabit: Identifiable {
    var id = UUID()
    var name: String
    var unit: String
    var currentAmount: Int
    var goalAmount: Int
}
