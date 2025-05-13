//
//  logginApp.swift
//  loggin
//
//  Created by Đinh Trần Việt Anh on 13/5/25.
//

import SwiftUI

@main
struct logginApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
           LogginView()
        }
    }
}
