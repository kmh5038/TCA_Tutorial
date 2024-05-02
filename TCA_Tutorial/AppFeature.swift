//
//  AppFeature.swift
//  TCA_Tutorial
//
//  Created by 김명현 on 3/28/24.
//

import ComposableArchitecture

@Reducer
struct AppFeature {
    struct State: Equatable {
        var tab1 = CounterFeature.State()
        var tab2 = CounterFeature.State()
        var tab3 = ContactsFeature.State()
    }
    
    enum Action {
        case tab1(CounterFeature.Action)
        case tab2(CounterFeature.Action)
        case tab3(ContactsFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.tab1, action: \.tab1) {
             CounterFeature()
           }
        Scope(state: \.tab2, action: \.tab2) {
             CounterFeature()
           }
        Scope(state: \.tab3, action: \.tab3) {
             ContactsFeature()
           }
        Reduce { state, action in
            // Core logic of the app feature
            return .none
        }
    }
}
