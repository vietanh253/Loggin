//
//  logginApp.swift
//  loggin
//
//  Created by Đinh Trần Việt Anh on 13/5/25.
//

import SwiftUI
//import FacebookCore

@main
struct logginApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
           LogginView()
        }
    }
}
