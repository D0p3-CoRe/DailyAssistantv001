import SwiftUI

struct HealthView: View {
    @State private var healthHabits: [HealthHabit] = [
        HealthHabit(name: "Woda", unit: "szklanki", currentAmount: 4, goalAmount: 8),
        HealthHabit(name: "Ćwiczenia", unit: "minuty", currentAmount: 20, goalAmount: 30),
        HealthHabit(name: "Medytacja", unit: "minuty", currentAmount: 5, goalAmount: 10)
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Twoje nawyki zdrowotne")
                    .font(.largeTitle)
                    .padding()

                List {
                    ForEach(healthHabits) { habit in
                        HealthHabitRowView(habit: habit, updateHabit: updateHabit)
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitle("Zdrowie", displayMode: .inline)
            }
        }
    }

    func updateHabit(_ habit: HealthHabit) {
        if let index = healthHabits.firstIndex(where: { $0.id == habit.id }) {
            healthHabits[index] = habit
        }
    }
}

struct HealthHabitRowView: View {
    @State var habit: HealthHabit
    var updateHabit: (HealthHabit) -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text(habit.name)
                .font(.headline)
            
            HStack {
                Text("Cel: \(habit.currentAmount)/\(habit.goalAmount) \(habit.unit)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Button(action: incrementHabit) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                        .font(.title)
                }
            }
            ProgressView(value: Double(habit.currentAmount), total: Double(habit.goalAmount))
                .accentColor(.green)
        }
        .padding(.vertical, 5)
    }

    func incrementHabit() {
        if habit.currentAmount < habit.goalAmount {
            habit.currentAmount += 1
            updateHabit(habit)
        }
    }
}
