import SwiftUI

struct ProductCard: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(product.image)
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .cornerRadius(10)
            Text(product.name)
                .font(.subheadline)
                .fontWeight(.medium)
            Text(product.description)
                .font(.footnote)
                .foregroundColor(.gray)
            HStack {
                Text("₸\(product.price, specifier: "%.2f")")
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(.green)
                Spacer()
                Button(action: {
                    // Add to cart action
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .clipShape(Circle())
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
    }
}
