//
//  ContacsFeature.swift
//  TCA_Tutorial
//
//  Created by 김명현 on 3/28/24.
//

import ComposableArchitecture
import Foundation

struct Contact: Equatable, Identifiable {
    var id: UUID
    var name: String
}

@Reducer
struct ContactsFeature {
    @ObservableState
    struct State: Equatable {
        var contacts: IdentifiedArrayOf<Contact> = []
    }
    
    enum Action {
        case addButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                return .none
            }
        }
    }
}

