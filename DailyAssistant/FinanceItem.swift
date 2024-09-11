import Foundation

enum FinanceType {
    case expense // Wydatek
    case income  // Wpływ
}

struct FinanceItem: Identifiable, Equatable { // Dodanie Equatable
    var id = UUID()
    var title: String
    var amount: Double
    var date: Date
    var category: String
    var type: FinanceType
    
    // Dodanie metody porównawczej do Equatable
    static func == (lhs: FinanceItem, rhs: FinanceItem) -> Bool {
        return lhs.id == rhs.id
    }
}

