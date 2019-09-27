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
    
//    init() {
//        fetchTemplatesFromServer()
//    }
    
    let baseURL = URL(string: "https://dev-libs.herokuapp.com/api")!
    
    var bearer: Bearer?
    var user: Int?
    var template: Template?
    
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
    
//    func fetchTemplatesFromServer(completion: @escaping () -> Void = { }) {
//        guard let userID = template?.userID else { return }
//        let templateURL = baseURL
//            .appendingPathComponent("users")
//            .appendingPathComponent("\(userID)")
//            .appendingPathComponent("templates")
//        let requestURL = templateURL.appendingPathExtension("json")
//        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
//            if let error = error {
//                NSLog("Error fetching templates: \(error)")
//                completion()
//            }
//            guard let data = data else {
//                NSLog("No data returned from data task")
//                completion()
//                return
//            }
//            do {
//                let decoder = JSONDecoder()
//                let templateReprentations = try decoder.decode([String: TemplateRepresentation].self, from: data).map({ $0.value })
//                self.updateTemplates(with: templateReprentations)
//            } catch {
//                NSLog("Error decoding: \(error)")
//            }
//        }.resume()
//    }
    
//    func updateTemplates(with representations: [TemplateRepresentation]) {
//
//        let idsToFetch = representations.compactMap({$0.id})
//
//        let representationsByID = Dictionary(uniqueKeysWithValues: zip(idsToFetch, representations))
//
//        var templatesToCreate = representationsByID
//        let context = CoreDataStack.shared.container.newBackgroundContext()
//        context.performAndWait {
//            do {
//                let fetchRequest: NSFetchRequest<Template> = Template.fetchRequest()
//
//                fetchRequest.predicate = NSPredicate(format: "id IN %@", idsToFetch)
//
//                let existingTemplates = try context.fetch(fetchRequest)
//
//                for template in existingTemplates {
//                    let id = template.id
//                    guard let representation = representationsByID[Int(id)] else { continue }
//                    template.id = Int16(representation.id)
//                    template.programmingLanguage = representation.programmingLanguage
//                    template.noun = representation.noun
//                    template.verb = representation.verb
//                    template.ingVerb = representation.ingVerb
//                    template.edVerb = representation.edVerb
//                    template.noun2 = representation.noun2
//                    template.userID = Int16(representation.userID)
//                    templatesToCreate.removeValue(forKey: Int(id))
//                }
//
//                for representation in templatesToCreate.values {
//                    Template(templateRepresentation: representation, context: context)
//                }
//                CoreDataStack.shared.save(context: context)
//            } catch {
//                NSLog("Error fetching templates from persistent store: \(error)")
//            }
//        }
//    }
    
//    func put(template: Template, completion: @escaping () -> Void = { }) {
//
//        let baseURL = URL(string: "https://dev-libs.herokuapp.com/api/templates/:id")!
//
//        let requestURL = baseURL
//            .appendingPathExtension("json")
//
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = HTTPMethod.put.rawValue
//
//        guard let templateRepresentation = template.templateRepresentation else {
//            NSLog("Template Representation is nil")
//            completion()
//            return
//        }
//
//        do {
//            request.httpBody = try JSONEncoder().encode(templateRepresentation)
//        } catch {
//            NSLog("Error encoding template representation: \(error)")
//            completion()
//            return
//        }
//
//        URLSession.shared.dataTask(with: request) { (_, _, error) in
//
//            if let error = error {
//                NSLog("Error PUTting template: \(error)")
//                completion()
//                return
//            }
//
//            completion()
//        }.resume()
//    }
    
    // CREATE, UPDATE, DELETE TEMPLATE FUNCS
    func createTemplate(id: UUID, programmingLanguage: String, noun: String, verb: String, ingVerb: String, edVerb: String, noun2: String, title: String) -> Template {
        
        let template = Template(id: id, programmingLanguage: programmingLanguage, noun: noun, verb: verb, ingVerb: ingVerb, edVerb: edVerb, noun2: noun2, title: title, context: CoreDataStack.shared.mainContext)
        
        CoreDataStack.shared.save()
//        put(template: template)
        
        return template
    }
    
    func updateTemplate(template: Template, id: UUID, programmingLanguage: String, noun: String, verb: String, ingVerb: String, edVerb: String, noun2: String, userID: Int) {
        
        template.id = id
        template.programmingLanguage =  programmingLanguage
        template.noun = noun
        template.verb = verb
        template.ingVerb = ingVerb
        template.edVerb = edVerb
        template.noun2 = noun2
  
//        put(template: template)
        
        CoreDataStack.shared.save()
    }
    
    func deleteTemplate(template: Template) {
        
        CoreDataStack.shared.mainContext.delete(template)
        CoreDataStack.shared.save()
    }
}
