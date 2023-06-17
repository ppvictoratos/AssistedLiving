//
//  DataController.swift
//  NINEMUSES
//
//  Created by Petie Positivo on 6/17/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "NINEMUSES")
    
    init () {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to l0ad \(error.localizedDescription)")
            }
        }
    }
}
