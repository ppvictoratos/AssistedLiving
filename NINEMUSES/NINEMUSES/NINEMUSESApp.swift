//
//  NINEMUSESApp.swift
//  NINEMUSES
//
//  Created by Petie Positivo on 6/17/23.
//

import SwiftUI

@main
struct NINEMUSESApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
