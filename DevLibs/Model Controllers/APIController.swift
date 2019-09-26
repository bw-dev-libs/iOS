//
//  APIcontroller.swift
//  DevLibs
//
//  Created by Ciara Beitel on 9/25/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import Foundation
import CoreData

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case encodingError
    case responseError
    case otherError(Error)
    case noData
    case noDecode
    case noToken
}

class APIController {
    
    init() {
        fetchTemplatesFromServer()
    }
    
    let baseURL = URL(string: "https://dev-libs.herokuapp.com/api")!
    
    var bearer: Bearer?
    var user: Int?
    
    func signUp(with user: User, completion: @escaping (NetworkError?) -> Void) {
        let signUpURL = baseURL
            .appendingPathComponent("auth")
            .appendingPathComponent("register")
        
        var request = URLRequest(url: signUpURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        
        do {
            let userData = try encoder.encode(user)
            request.httpBody = userData
        } catch {
            NSLog("Error encoding user: \(error)")
            completion(.encodingError)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode < 200 || response.statusCode >= 300 {
                completion(.responseError)
                return
            }
            
            if let error = error {
                NSLog("Error creating user on server: \(error)")
                completion(.otherError(error))
                return
            }
            
            completion(nil)
        }.resume()
    }
    
    func login(with user: User, completion: @escaping (NetworkError?) -> Void) {
        let loginURL = baseURL
            .appendingPathComponent("auth")
            .appendingPathComponent("login")
        
        var request = URLRequest(url: loginURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        
        do {
            request.httpBody = try encoder.encode(user)
        } catch {
            NSLog("Error encoding user object: \(error)")
            completion(.encodingError)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode < 200 || response.statusCode >= 300 {
                completion(.responseError)
                return
            }
            
            if let error = error {
                NSLog("Error logging in: \(error)")
                completion(.otherError(error))
                return
            }
        
            guard let data = data else {
                completion(.noData)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(LoginResponse.self, from: data)
                self.bearer = Bearer(token: response.token)
                self.user = response.user
            } catch {
                completion(.noDecode)
                return
            }
            completion(nil)
        }.resume()
    }
    
    func fetchTemplatesFromServer(completion: @escaping () -> Void = { }) {
        let userID: LoginResponse
        let templateURL = baseURL
            .appendingPathComponent("users")
            .appendingPathComponent(String(userID.user))
            .appendingPathComponent("templates")
        let requestURL = baseURL.appendingPathExtension("json")
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching templates: \(error)")
                completion()
            }
            guard let data = data else {
                NSLog("No data returned from data task")
                completion()
                return
            }
            do {
                let decoder = JSONDecoder()
                let templateReprentations = try decoder.decode([String: TemplateRepresentation].self, from: data).map({ $0.value })
                self.updateTemplates(with: templateReprentations)
            } catch {
                NSLog("Error decoding: \(error)")
            }
            }.resume()
    }
    
    func updateTemplates(with representations: [TemplateRepresentation]) {
              
        let idsToFetch = representations.compactMap({$0.id})
        
        let representationsByID = Dictionary(uniqueKeysWithValues: zip(idsToFetch, representations))
        
        var templatesToCreate = representationsByID
        let context = CoreDataStack.shared.container.newBackgroundContext()
        context.performAndWait {
            do {
                let fetchRequest: NSFetchRequest<Template> = Template.fetchRequest()
                
                fetchRequest.predicate = NSPredicate(format: "id IN %@", idsToFetch)
               
                let existingTemplates = try context.fetch(fetchRequest)
                
                for template in existingTemplates {
                    let id = template.id
                    guard let representation = representationsByID[Int(id)] else { continue }
                    template.id = representation.id
                    template.programmingLanguage = representation.programmingLanguage
                    template.noun = representation.noun
                    template.verb = representation.verb
                    template.ingVerb = representation.ingVerb
                    template.edVerb = representation.edVerb
                    template.noun2 = representation.noun2
                    template.userID = representation.userID
                    templatesToCreate.removeValue(forKey: Int(id))
                }
                
                for representation in templatesToCreate.values {
                    Template(templateRepresentation: representation, context: context)
                }
                CoreDataStack.shared.save(context: context)
            } catch {
                NSLog("Error fetching templates from persistent store: \(error)")
            }
        }
    }



    
}
