//
//  A2MApp.swift
//  A2M
//
//  Created by Tsz Hoi Leung on 3/5/2023.
//

import SwiftUI

@main
struct A2MApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
