//
//  A2MApp.swift
//  A2M
//
//  Created by Tsz Hoi Leung on 3/5/2023.
//

import SwiftUI
@main
struct A2MApp: App {
    let persistentStorageController = PersistentStorageController.shared

    var body: some Scene {
        WindowGroup {
            PlaceList()
                .environment(\.managedObjectContext, persistentStorageController.context)
        }
    }
}
