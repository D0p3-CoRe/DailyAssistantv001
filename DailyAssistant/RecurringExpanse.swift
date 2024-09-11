import Foundation

struct RecurringExpense: Identifiable {
    var id = UUID()
    var title: String
    var amount: Double
    var dueDate: Date
    var frequency: String
    var category: ExpenseCategory
}

