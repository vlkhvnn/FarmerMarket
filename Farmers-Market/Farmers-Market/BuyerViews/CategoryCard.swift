import SwiftUI

struct CategoryCard: View {
    let imageName: String
    let label: String

    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 80)
                .padding(8)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
            Text(label)
                .font(.subheadline)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity)
    }
}
