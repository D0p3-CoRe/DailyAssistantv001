import SwiftUI

struct AddFinanceItemForm: View {
    var isExpense: Bool
    @State private var title: String = ""
    @State private var amount: String = ""
    @State private var date: Date = Date()
    var addItem: (FinanceItem) -> Void
    @Environment(\.presentationMode) var presentationMode // Dodanie środowiska do zamykania widoku

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(isExpense ? "Dodaj Wydatek" : "Dodaj Wpływ")) {
                    TextField("Tytuł", text: $title)
                    TextField("Kwota", text: $amount)
                        .keyboardType(.decimalPad)
                    DatePicker("Data", selection: $date, displayedComponents: .date)
                }
                Button(action: submitItem) {
                    Text(isExpense ? "Dodaj Wydatek" : "Dodaj Wpływ")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isExpense ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle(isExpense ? "Nowy Wydatek" : "Nowy Wpływ")
        }
    }

    func submitItem() {
        guard let amountValue = Double(amount) else { return }
        let newItem = FinanceItem(title: title, amount: amountValue, date: date, category: isExpense ? "Wydatek" : "Wpływ", type: isExpense ? .expense : .income)
        addItem(newItem)
        presentationMode.wrappedValue.dismiss() // Zamknij widok po dodaniu elementu
    }
}
