//
//  MockListWebService.swift
//  TheCatAppTests
//
//  Created by isha pathak on 30/06/22.
//

import XCTest
@testable import TheCatApp

class MockListWebService {
        var shouldServiceReturnError = false
        var listServiceRequestWasCalled = false
        var mockJSONData: [Cat]?

        enum MockListServiceError: Error{
            case list
        }
        func reset(){
            shouldServiceReturnError = false
            listServiceRequestWasCalled = false
        }
        convenience init(){
            self.init(false)
        }
        init(_ shouldServiceReturnError: Bool) {
            self.shouldServiceReturnError = shouldServiceReturnError
            self.getMockJSONData()
        }

        func getMockJSONData(){
            if let path = Bundle.main.path(forResource: "data", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: [])
                    let decoder = JSONDecoder()
                    self.mockJSONData = try decoder.decode([Cat].self, from: data)
                } catch {
                    print("Error loading JSON file")
                }
            } else {
                print("File not found")
            }
        }
    }
extension MockListWebService: ListWebServiceProtocol {
    
    func fetchListFromServer(completion: @escaping ([Cat]?, Error?) -> Void) {
             listServiceRequestWasCalled = true
            if shouldServiceReturnError {
                    completion(nil, MockListServiceError.list)
                   } else {
                    completion(self.mockJSONData, nil)
                   }
        }

    }
