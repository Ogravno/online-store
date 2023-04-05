//
//  ViewModel.swift
//  online-store
//
//  Created by Odin Grav on 03/04/2023.
//

import Foundation

class StoreViewModel: ObservableObject {
    @Published var user: User = User()
    @Published var token: String = ""
    
    @Published var products: [Product] = []
    
    @Published var cart: Cart = Cart()
    
    func login(username: String, password: String) async {
        do {
            user = try await checkUserLogin(username: username, password: password)
            token = user.token ?? ""
        }
        
        catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
    }
    
    func checkUserLogin(username: String, password: String) async throws -> User {
        let body: [String: Any] = ["username": username, "password": password]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body)

        let url = URL(string: "https://dummyjson.com/auth/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (response, _) = try await URLSession.shared.data(for: request)
        
        let svar = try JSONDecoder().decode(User.self, from: response)
        return svar
    }
    
    func setUserDetails() async {
        do {
            let url: String = "https://dummyjson.com/users/" + String(user.id ?? 0)
            print(url)
            
            user = try await getUserDetails(urlString: url)
        }
        
        catch {
            print(String(describing: error))
        }
    }
    
    func getUserDetails(urlString: String) async throws -> User {
        let url = URL(string: urlString)!
        let urlrequest = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: urlrequest)
        let svar = try JSONDecoder().decode(User.self, from: data)
        return svar
    }
    
    func setProducts() async {
        do {
            products = try await getProducts(urlString: "https://dummyjson.com/products")
        }
        
        catch {
            print(error.localizedDescription)
        }
    }
    
    func getProducts(urlString: String) async throws -> [Product] {
        let url = URL(string: urlString)!
        let urlrequest = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: urlrequest)
        let svar = try JSONDecoder().decode(ProductMeta.self, from: data)
        return svar.products
    }

    func setCart() async {
        do {
            cart = try await getCart(urlString: "https://dummyjson.com/carts/user/" + String(user.id ?? 0))
        }
        
        catch {
            print(error.localizedDescription)
        }
    }
    
    func getCart(urlString: String) async throws -> Cart {
        let url = URL(string: urlString)!
        let urlrequest = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: urlrequest)
        let svar = try JSONDecoder().decode(CartMeta.self, from: data)
        return svar.carts[0]
    }
    
    func addToCart(product: Product) {
        let newCartProduct: CartProduct = CartProduct(id: product.id, title: product.title, price: product.price, quantity: 1, discountPercentage: product.discountPercentage)
        
        let existingProductIndex = cart.products!.firstIndex(where: {$0.id == product.id})
        
        if (existingProductIndex == nil) {
            cart.products?.append(newCartProduct)
        }
        
        else {
            cart.products![existingProductIndex!].quantity += 1
        }
        
        print(product)
        print(existingProductIndex)
        
    }
}
