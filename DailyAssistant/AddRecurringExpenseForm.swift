import SwiftUI
import Foundation
struct AddRecurringExpenseForm: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String = ""
    @State private var amount: String = ""
    @State private var dueDate: Date = Date()
    @State private var frequency: String = "Miesięcznie"
    @State private var selectedCategory: ExpenseCategory = .dom // Nowe pole kategorii
    
    var addRecurringExpense: (RecurringExpense) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Nowy Stały Wydatek")) {
                    TextField("Tytuł", text: $title)
                    TextField("Kwota", text: $amount)
                        .keyboardType(.decimalPad)
                    DatePicker("Data płatności", selection: $dueDate, displayedComponents: .date)
                    TextField("Częstotliwość", text: $frequency)
                    Picker("Kategoria", selection: $selectedCategory) {
                        ForEach(ExpenseCategory.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                }
                
                Button(action: {
                    if let amountValue = Double(amount) {
                        let newExpense = RecurringExpense(title: title, amount: amountValue, dueDate: dueDate, frequency: frequency, category: selectedCategory)
                        addRecurringExpense(newExpense)
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Dodaj Wydatek")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Dodaj Wydatek")
        }
    }
}

