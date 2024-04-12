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
        // 부모 State에 자식 State를 포함
        var tab1 = CounterFeature.State()
        var tab2 = CounterFeature.State()
        var tab3 = ContactFeature.State()
    }
    
    enum Action {
        // 부모 Action에 자식 Action을 포함
        case tab1(CounterFeature.Action)
        case tab2(CounterFeature.Action)
        case tab3(ContactFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        // body 프로퍼티 안에 Scope를 사용해서 자식 Reducer 정의.
        Scope(state: \.tab1, action: \.tab1) {
            CounterFeature()
        }
        Scope(state: \.tab2, action: \.tab2) {
            CounterFeature()
        }
        Scope(state: \.tab3, action: \.tab3) {
            ContactFeature()
        }
        
        Reduce { state, action in
            return .none
        }
    }
}
