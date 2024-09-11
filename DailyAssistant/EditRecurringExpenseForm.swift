import SwiftUI

struct EditRecurringExpenseForm: View {
    @Binding var expense: RecurringExpense
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edytuj Stały Wydatek")) {
                    TextField("Tytuł", text: $expense.title)
                    TextField("Kwota", value: $expense.amount, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                    DatePicker("Data płatności", selection: $expense.dueDate, displayedComponents: .date)
                    TextField("Częstotliwość", text: $expense.frequency)
                }
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Zapisz")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Edycja Wydatku")
        }
    }
}
