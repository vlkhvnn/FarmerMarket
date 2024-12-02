import Foundation
import Alamofire

enum URLs: String {

    case base = "https://farmers-market-next.vercel.app"
    case buyerLogin = "/api/buyer/auth"
    case farmerLogin = "/api/farmer/auth"
    case getAllProducts = "/api/buyer/products"
    case getOrderHistory = "/api/orders/history"
}

struct FarmerResponse: Decodable {
    let message: String
    let farmer: Farmer
}

struct BuyerResponse: Decodable {
    let message: String
    let buyer: Buyer
}

struct ProductsResponse: Decodable {
    let products: [Product]
}

struct ConfirmOrderRequest: Encodable {
    let buyerId: String
    let products: [ProductQuantity]
}

struct ProductQuantity: Encodable {
    let productId: String
    let quantity: Int
}

struct ConfirmOrderResponse: Decodable {
    let message: String
    let order: OrderConfirmation
}

struct OrderConfirmation: Decodable, Identifiable {
    let id: String
    let buyerId: String
    let totalPrice: Double
    let status: String
    let products: [OrderProduct]
}

struct OrderProduct: Decodable, Identifiable, Hashable {
    let id: String
    let orderId: String
    let productId: String
    let quantity: Int
    let product: ProductDetails
}

struct ProductDetails: Decodable, Identifiable, Hashable {
    let id: String
    let name: String
    let description: String
    let price: Double
    let quantity: Int
    let category: String
    let image: String
    let farmerId: String
    let isOutOfStock: Bool
    let createdAt: String
    let updatedAt: String
}

struct OrderHistoryResponse: Decodable {
    let orders: [Order]
}

struct ProductResponse: Decodable {
    let message: String
    let product: Product
}


struct UpdateProductResponse: Decodable {
    let message: String
    let updatedProduct: Product
}

struct NotificationsResponse: Decodable {
    let message: String
    let notifications: [Notification]
}

final class APIService {
    static let shared = APIService()
    
    static var userId = ""
    
    private init() {}
    
    func buyerLogin(email: String, password: String, completion: @escaping (Result<Buyer, Error>) -> Void) {
        let url = URLs.base.rawValue + URLs.buyerLogin.rawValue
        
        // Prepare request payload
        let parameters: [String: Any] = [
            "action": "login",
            "email": email,
            "password": password
        ]
        
        // Send POST request
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let buyerResponse = try decoder.decode(BuyerResponse.self, from: data)
                        completion(.success(buyerResponse.buyer))
                        APIService.userId = buyerResponse.buyer.id
                    } catch {
                        print("Decoding error: \(error.localizedDescription)")
                        print("Response data: \(String(data: data, encoding: .utf8) ?? "No data")")
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("Request failed: \(error.localizedDescription)")
                    if let data = response.data {
                        print("Error Response: \(String(data: data, encoding: .utf8) ?? "No data")")
                    }
                    completion(.failure(error))
                }
            }
    }
    
    func farmerLogin(email: String, password: String, completion: @escaping (Result<Farmer, Error>) -> Void) {
        let url = URLs.base.rawValue + URLs.farmerLogin.rawValue
        
        let parameters: [String: Any] = [
            "action": "login",
            "email": email,
            "password": password
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Raw Response Data: \(jsonString)")
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        decoder.dateDecodingStrategy = .iso8601
                        
                        let farmerResponse = try decoder.decode(FarmerResponse.self, from: data)
                        completion(.success(farmerResponse.farmer))
                        APIService.userId = farmerResponse.farmer.id
                    } catch {
                        print("Decoding error: \(error.localizedDescription)")
                        print("Response data: \(String(data: data, encoding: .utf8) ?? "No data")")
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("Request failed: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
    }
    
    func buyerRegister(
        email: String,
        password: String,
        firstName: String,
        lastName: String,
        paymentMethod: String,
        address: String,
        phoneNumber: String,
        completion: @escaping (Result<Buyer, Error>) -> Void
    ) {
        let url = URLs.base.rawValue + URLs.buyerLogin.rawValue
        
        // Prepare request payload
        let parameters: [String: Any] = [
            "action": "register",
            "email": email,
            "password": password,
            "firstName": firstName,
            "lastName": lastName,
            "paymentMethod": paymentMethod,
            "address": address,
            "phoneNumber": phoneNumber
        ]
        
        // Send POST request
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let buyerResponse = try decoder.decode(BuyerResponse.self, from: data)
                        completion(.success(buyerResponse.buyer))
                        APIService.userId = buyerResponse.buyer.id
                    } catch {
                        print("Decoding error: \(error.localizedDescription)")
                        print("Response data: \(String(data: data, encoding: .utf8) ?? "No data")")
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("Request failed: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
    }
    
    func farmerRegister(
        email: String,
        password: String,
        firstName: String,
        lastName: String,
        farmName: String,
        farmAddress: String,
        farmSize: Int,
        phoneNumber: String,
        completion: @escaping (Result<Farmer, Error>) -> Void
    ) {
        let url = URLs.base.rawValue + URLs.farmerLogin.rawValue
        
        let parameters: [String: Any] = [
            "action": "register",
            "email": email,
            "password": password,
            "firstName": firstName,
            "lastName": lastName,
            "farmName": farmName,
            "farmAddress": farmAddress,
            "farmSize": farmSize,
            "phoneNumber": phoneNumber
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let farmerResponse = try decoder.decode(FarmerResponse.self, from: data)
                        completion(.success(farmerResponse.farmer))
                        APIService.userId = farmerResponse.farmer.id
                    } catch {
                        print("Decoding error: \(error.localizedDescription)")
                        print("Response data: \(String(data: data, encoding: .utf8) ?? "No data")")
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("Request failed: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
    }
    
    func getAllProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        let url = URLs.base.rawValue + URLs.getAllProducts.rawValue

        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let productsResponse = try decoder.decode(ProductsResponse.self, from: data)
                        completion(.success(productsResponse.products))
                    } catch {
                        print("Decoding error: \(error.localizedDescription)")
                        print("Response data: \(String(data: data, encoding: .utf8) ?? "No data")")
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("Request failed: \(error.localizedDescription)")
                    if let data = response.data {
                        print("Response data: \(String(data: data, encoding: .utf8) ?? "No data")")
                    }
                    completion(.failure(error))
                }
            }
    }
    
    func getOrderHistory(completion: @escaping (Result<[Order], Error>) -> Void) {
        let url = URLs.base.rawValue + URLs.getOrderHistory.rawValue
        
        let parameters: [String: Any] = [
            "buyerId": APIService.userId
        ]
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [Order].self) { response in
                switch response.result {
                case .success(let orders):
                    completion(.success(orders))
                case .failure(let error):
                    print("Request failed: \(error.localizedDescription)")
                    if let data = response.data {
                        print("Error Response: \(String(data: data, encoding: .utf8) ?? "No data")")
                    }
                    completion(.failure(error))
                }
            }
    }

    
    func confirmOrder(request: ConfirmOrderRequest, completion: @escaping (Result<ConfirmOrderResponse, Error>) -> Void) {
            let url = URLs.base.rawValue + "/api/orderv2" // Ensure this matches the endpoint
            
            // Optionally, add headers (e.g., Authorization)
            let headers: HTTPHeaders = [
                "Content-Type": "application/json"
                // "Authorization": "Bearer YOUR_AUTH_TOKEN" // Uncomment and set if needed
            ]
            
            // Send POST request with JSON body
            AF.request(url, method: .post, parameters: request, encoder: JSONParameterEncoder.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: ConfirmOrderResponse.self) { response in
                    switch response.result {
                    case .success(let confirmOrderResponse):
                        completion(.success(confirmOrderResponse))
                    case .failure(let error):
                        print("Order confirmation failed: \(error.localizedDescription)")
                        if let data = response.data {
                            print("Error Response: \(String(data: data, encoding: .utf8) ?? "No data")")
                        }
                        completion(.failure(error))
                    }
                }
        }
    
    func addProduct(
            farmerId: String,
            name: String,
            description: String,
            price: Float,
            quantity: Int,
            category: String,
            image: String,
            completion: @escaping (Result<Product, Error>) -> Void
        ) {
            let url = URLs.base.rawValue + "/api/farmer/products"
            
            let parameters: [String: Any] = [
                "farmerId": farmerId,
                "name": name,
                "description": description,
                "price": price,
                "quantity": quantity,
                "category": category,
                "image": image
            ]
            
            let headers: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: ProductResponse.self) { response in
                    switch response.result {
                    case .success(let productResponse):
                        completion(.success(productResponse.product))
                    case .failure(let error):
                        print("Error adding product: \(error.localizedDescription)")
                        if let data = response.data {
                            print("Error Response: \(String(data: data, encoding: .utf8) ?? "No data")")
                        }
                        completion(.failure(error))
                    }
                }
        }
    
    func fetchFarmerProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
            let url = URLs.base.rawValue + "/api/farmer/products"
            let parameters: [String: Any] = [
                "farmerId": Self.userId
            ]
            
            let headers: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            
            AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: [Product].self) { response in
                    switch response.result {
                    case .success(let products):
                        completion(.success(products))
                    case .failure(let error):
                        print("Failed to fetch products: \(error.localizedDescription)")
                        if let data = response.data {
                            print("Error response: \(String(data: data, encoding: .utf8) ?? "No data")")
                        }
                        completion(.failure(error))
                    }
                }
        }
    
    func updateProduct(
            productId: String,
            updatedFields: [String: Any],
            completion: @escaping (Result<Product, Error>) -> Void
    ) {
        let url = URLs.base.rawValue + "/api/farmer/products/\(productId)"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .patch, parameters: updatedFields, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: UpdateProductResponse.self) { response in
                switch response.result {
                case .success(let updateResponse):
                    completion(.success(updateResponse.updatedProduct))
                case .failure(let error):
                    print("Error updating product: \(error.localizedDescription)")
                    if let data = response.data {
                        print("Error response: \(String(data: data, encoding: .utf8) ?? "No data")")
                    }
                    completion(.failure(error))
                }
            }
    }

    func fetchNotifications(completion: @escaping (Result<[Notification], Error>) -> Void) {
            let url = URLs.base.rawValue + "/api/notifications"
        let parameters: [String: String] = ["farmerId": Self.userId]
            
            let headers: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            
            AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: headers)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: NotificationsResponse.self) { response in
                    switch response.result {
                    case .success(let notificationsResponse):
                        completion(.success(notificationsResponse.notifications))
                    case .failure(let error):
                        print("Error fetching notifications: \(error.localizedDescription)")
                        if let data = response.data {
                            print("Error response: \(String(data: data, encoding: .utf8) ?? "No data")")
                        }
                        completion(.failure(error))
                    }
                }
        }
}

