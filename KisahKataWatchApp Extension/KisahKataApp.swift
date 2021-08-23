//
//  KisahKataApp.swift
//  KisahKataWatchApp Extension
//
//  Created by Nahl Basalamah on 11/01/1443 AH.
//

import SwiftUI

@main
struct KisahKataApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                PlayView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
