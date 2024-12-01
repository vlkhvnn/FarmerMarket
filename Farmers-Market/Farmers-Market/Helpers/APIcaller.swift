import Foundation
import Alamofire

enum URLs: String {

    case base = "https://farmers-market-next.vercel.app"
    case buyerLogin = "/api/buyer/auth"
    case farmerLogin = "/api/farmer/auth"
    case getAllProducts = "/api/buyer/products"
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

final class APIService {
    static let shared = APIService()
    
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
}

