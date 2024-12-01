import SwiftUI

struct ProductDetailView: View {
    let product: Product

    @State private var quantity: Int = 1

    var body: some View {
        VStack(spacing: 16) {
            // Product Image
            Image(systemName: product.image)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundColor(.gray)
                .padding(.top)

            // Product Name and Price
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(product.name)
                        .font(.title)
                        .bold()
                    Spacer()
                    Image(systemName: "heart")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)

                HStack {
                    Text("1kg, Price")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("Available: \(product.quantity)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)

                Text("\(String(format: "%.0f", product.price)) ₸")
                    .font(.title2)
                    .bold()
                    .padding(.horizontal)
            }

            // Quantity Selector
            HStack {
                Button(action: {
                    if quantity > 1 { quantity -= 1 }
                }) {
                    Image(systemName: "minus.circle")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                Text("\(quantity)")
                    .font(.title2)
                    .frame(width: 40)
                Button(action: {
                    if quantity < product.quantity { quantity += 1 }
                }) {
                    Image(systemName: "plus.circle")
                        .font(.title2)
                        .foregroundColor(.green)
                }
            }
            .padding()

            VStack(alignment: .leading, spacing: 8) {
                Text("Description")
                    .font(.headline)
                    .bold()

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("Type:")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Text(product.name)
                    }
                    HStack {
                        Text("Category:")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Text(product.category)
                    }
                    HStack {
                        Text("Farm:")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Text(product.farmerName)
                    }
                    HStack {
                        Text("Seller:")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("\(product.farmerName)")
                    }
                }
                .font(.subheadline)
            }
            .padding(.horizontal)

            Spacer()

            // Buttons
            VStack(spacing: 12) {
                HStack {
                    Button(action: {
                        // Counter-offer action
                    }) {
                        HStack {
                            Image(systemName: "dollarsign.circle")
                            Text("Counter-Offer")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }

                    Button(action: {
                        // Chat action
                    }) {
                        Image(systemName: "bubble.left.and.bubble.right.fill")
                            .font(.title)
                            .padding()
                            .background(Color(UIColor.systemGray5))
                            .clipShape(Circle())
                    }
                    .padding(4)
                }
                .padding(.horizontal)

                Button(action: {
                    // Add to cart action
                }) {
                    HStack {
                        Image(systemName: "cart")
                        Text("Add to cart")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom, 20) // Add padding to avoid overlap
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
