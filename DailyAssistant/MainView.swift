import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            // Ekran Finansów
            FinanceView()
                .tabItem {
                    Label("Finanse", systemImage: "dollarsign.circle")
                }
            
            // Ekran Zdrowia
            HealthView()
                .tabItem {
                    Label("Zdrowie", systemImage: "heart.circle")
                }
            
            // Ekran Przypomnień
            RemindersView()
                .tabItem {
                    Label("Przypomnienia", systemImage: "bell.circle")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
