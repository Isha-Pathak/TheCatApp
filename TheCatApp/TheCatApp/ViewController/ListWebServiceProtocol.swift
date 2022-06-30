//
//  ListWebServiceProtocol.swift
//  TheCatApp
//
//  Created by isha pathak on 30/06/22.
//

import UIKit

import Foundation

protocol ListWebServiceProtocol {
    func fetchListFromServer(completion: @escaping (_ album : [Cat]?, _ error: Error?) -> Void)
}
