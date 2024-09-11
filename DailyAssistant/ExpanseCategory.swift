import Foundation

enum ExpenseCategory: String, CaseIterable, Identifiable {
    case dom = "Dom"
    case dzieci = "Dzieci"
    case zwierzeta = "Zwierzęta"
    case transport = "Transport"
    case zdrowie = "Zdrowie"
    case rozrywka = "Rozrywka"
    case jedzenie = "Jedzenie"
    case inne = "Inne"
    
    var id: String { self.rawValue }
}
