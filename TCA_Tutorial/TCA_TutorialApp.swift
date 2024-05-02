//
//  TCA_TutorialApp.swift
//  TCA_Tutorial
//
//  Created by 김명현 on 3/27/24.
//

import ComposableArchitecture
import SwiftUI

@main
struct TCA_TutorialApp: App {
    static let store = Store(initialState: AppFeature.State()) {
        AppFeature()
            ._printChanges()
    }
    var body: some Scene {
        WindowGroup {
            AppView(store: TCA_TutorialApp.store)
        }
    }
}
