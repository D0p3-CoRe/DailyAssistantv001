import SwiftUI

struct RemindersView: View {
    @State private var reminders: [Reminder] = [
        Reminder(title: "Spotkanie z klientem", date: Date().addingTimeInterval(3600), description: "Omówienie projektu", isActive: true),
        Reminder(title: "Przegląd samochodu", date: Date().addingTimeInterval(86400), description: "Stacja kontroli pojazdów", isActive: true),
        Reminder(title: "Opłata OC", date: Date().addingTimeInterval(604800), description: "Zapłata składki", isActive: true)
    ]
    
    @State private var newReminderTitle: String = ""
    @State private var newReminderDescription: String = ""
    @State private var newReminderDate: Date = Date()
    @State private var showAddReminderForm: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Button(action: { showAddReminderForm = true }) {
                    Text("Dodaj nowe przypomnienie")
                        .foregroundColor(.blue)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 1)
                        )
                }
                .padding()

                List {
                    ForEach(reminders) { reminder in
                        ReminderRowView(reminder: reminder, toggleActive: toggleReminderActive)
                    }
                    .onDelete(perform: deleteReminder)
                }
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitle("Przypomnienia", displayMode: .inline)
            }
        }
        .sheet(isPresented: $showAddReminderForm) {
            AddReminderForm(
                newReminderTitle: $newReminderTitle,
                newReminderDescription: $newReminderDescription,
                newReminderDate: $newReminderDate,
                addReminder: addReminder
            )
        }
    }

    func addReminder() {
        let newReminder = Reminder(
            title: newReminderTitle,
            date: newReminderDate,
            description: newReminderDescription,
            isActive: true
        )
        reminders.append(newReminder)
        clearFormFields()
    }

    func clearFormFields() {
        newReminderTitle = ""
        newReminderDescription = ""
        newReminderDate = Date()
        showAddReminderForm = false
    }

    func deleteReminder(at offsets: IndexSet) {
        reminders.remove(atOffsets: offsets)
    }

    func toggleReminderActive(reminder: Reminder) {
        if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminders[index].isActive.toggle()
        }
    }
}

struct ReminderRowView: View {
    var reminder: Reminder
    var toggleActive: (Reminder) -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(reminder.title)
                    .font(.headline)
                Text(reminder.date, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                if !reminder.description.isEmpty {
                    Text(reminder.description)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            Button(action: {
                toggleActive(reminder)
            }) {
                Image(systemName: reminder.isActive ? "bell.fill" : "bell.slash.fill")
                    .foregroundColor(reminder.isActive ? .green : .red)
            }
        }
    }
}

struct AddReminderForm: View {
    @Binding var newReminderTitle: String
    @Binding var newReminderDescription: String
    @Binding var newReminderDate: Date
    var addReminder: () -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Szczegóły przypomnienia")) {
                    TextField("Tytuł", text: $newReminderTitle)
                    TextField("Opis", text: $newReminderDescription)
                    DatePicker("Data", selection: $newReminderDate, displayedComponents: .date)
                }
                Button(action: addReminder) {
                    Text("Dodaj przypomnienie")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationBarTitle("Nowe przypomnienie", displayMode: .inline)
        }
    }
}
