import SwiftUI

struct FinanceRowView: View {
    var item: FinanceItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                Text(item.date, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text("\(item.amount, specifier: "%.2f") zł")
                .foregroundColor(item.type == .expense ? .red : .green)
        }
        .padding(.vertical, 4)
    }
}

struct FinanceRowView_Previews: PreviewProvider {
    static var previews: some View {
        FinanceRowView(item: FinanceItem(title: "Testowy Wydatek", amount: 100.0, date: Date(), category: "Jedzenie", type: .expense))
            .previewLayout(.sizeThatFits)
    }
}
