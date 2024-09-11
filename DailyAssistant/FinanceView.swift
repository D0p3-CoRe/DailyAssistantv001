import SwiftUI
import Foundation

struct FinanceView: View {
    @State private var financeItems: [FinanceItem] = []
    @State private var recurringExpenses: [RecurringExpense] = [
        RecurringExpense(title: "Opłata za mieszkanie", amount: 1200, dueDate: Date(), frequency: "Miesięcznie", category: .dom),
        RecurringExpense(title: "Internet", amount: 50, dueDate: Date(), frequency: "Miesięcznie", category: .inne)
    ]
    
    @State private var totalIncome: Double = 0.0
    @State private var totalExpenses: Double = 0.0
    @State private var balance: Double = 0.0
    
    @State private var showAddExpenseForm: Bool = false
    @State private var showAddIncomeForm: Bool = false
    @State private var editingRecurringExpense: RecurringExpense? = nil
    @State private var showAddRecurringExpenseForm: Bool = false
    
    @State private var selectedCategory: ExpenseCategory? = nil

    var body: some View {
        NavigationView {
            VStack {
                Text("Saldo: \(String(format: "%.2f", balance)) zł")
                    .font(.largeTitle)
                    .padding()

                List {
                    Section(header: Text("Wydatki")) {
                        ForEach(financeItems.filter { $0.type == .expense }) { item in
                            FinanceRowView(item: item)
                        }
                        .onDelete(perform: deleteExpense)
                    }
                    
                    Section(header: Text("Wpływy")) {
                        ForEach(financeItems.filter { $0.type == .income }) { item in
                            FinanceRowView(item: item)
                        }
                        .onDelete(perform: deleteIncome)
                    }
                    
                    Section(header: Text("Stałe Wydatki")) {
                        let nonEmptyCategories = ExpenseCategory.allCases.filter { category in
                            !recurringExpenses.filter { $0.category == category }.isEmpty
                        }
                        
                        ForEach(nonEmptyCategories, id: \.self) { category in
                            Section(header: Text("\(category.rawValue) (\(totalAmount(for: category), specifier: "%.2f") zł)")) {
                                if selectedCategory == category {
                                    ForEach(recurringExpenses.filter { $0.category == category }) { expense in
                                        HStack {
                                            Text("\(expense.title): \(String(format: "%.2f", expense.amount)) zł")
                                            Spacer()
                                            Button("Edytuj") {
                                                editingRecurringExpense = expense
                                            }
                                            .padding(.leading)
                                        }
                                    }
                                }
                            }
                            .onTapGesture {
                                withAnimation {
                                    if selectedCategory == category {
                                        selectedCategory = nil
                                    } else {
                                        selectedCategory = category
                                    }
                                }
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Finanse")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { showAddIncomeForm = true }) {
                            Label("Dodaj Wpływ", systemImage: "plus.circle")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showAddExpenseForm = true }) {
                            Label("Dodaj Wydatek", systemImage: "minus.circle")
                        }
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: { showAddRecurringExpenseForm = true }) {
                            Label("Dodaj Stały Wydatek", systemImage: "calendar.badge.plus")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showAddExpenseForm) {
            AddFinanceItemForm(isExpense: true, addItem: addFinanceItem)
        }
        .sheet(isPresented: $showAddIncomeForm) {
            AddFinanceItemForm(isExpense: false, addItem: addFinanceItem)
        }
        .sheet(item: $editingRecurringExpense) { expense in
            if let index = recurringExpenses.firstIndex(where: { $0.id == expense.id }) {
                EditRecurringExpenseForm(expense: $recurringExpenses[index])
            }
        }
        .sheet(isPresented: $showAddRecurringExpenseForm) {
            AddRecurringExpenseForm(addRecurringExpense: addRecurringExpense)
        }
        .onAppear(perform: calculateBalance)
    }

    func addFinanceItem(item: FinanceItem) {
        financeItems.append(item)
        calculateBalance()
    }
    
    func deleteExpense(at offsets: IndexSet) {
        for index in offsets {
            if financeItems[index].type == .expense {
                financeItems.remove(at: index)
            }
        }
        calculateBalance()
    }

    func deleteIncome(at offsets: IndexSet) {
        for index in offsets {
            if financeItems[index].type == .income {
                financeItems.remove(at: index)
            }
        }
        calculateBalance()
    }

    func deleteRecurringExpense(at offsets: IndexSet) {
        recurringExpenses.remove(atOffsets: offsets)
        calculateBalance()
    }

    func calculateBalance() {
        totalIncome = financeItems.filter { $0.type == .income }.map { $0.amount }.reduce(0, +)
        totalExpenses = financeItems.filter { $0.type == .expense }.map { $0.amount }.reduce(0, +)
        let recurringTotal = recurringExpenses.map { $0.amount }.reduce(0, +)
        balance = totalIncome - totalExpenses - recurringTotal
    }
    
    func addRecurringExpense(expense: RecurringExpense) {
        recurringExpenses.append(expense)
        calculateBalance()
    }
    
    private func totalAmount(for category: ExpenseCategory) -> Double {
        recurringExpenses.filter { $0.category == category }.map { $0.amount }.reduce(0, +)
    }
}
