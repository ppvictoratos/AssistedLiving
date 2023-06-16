//
//  _MUSESApp.swift
//  9MUSES
//
//  Created by Petie Positivo on 6/9/23.
//

import SwiftUI

@main
struct _MUSESApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            EnterNickname()
        }
    }
}
