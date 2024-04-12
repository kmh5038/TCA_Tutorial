//
//  ContactDetailView.swift
//  TCA_Tutorial
//
//  Created by 김명현 on 4/3/24.
//
import ComposableArchitecture
import SwiftUI

struct ContactDetailView: View {
    @Bindable var store: StoreOf<ContactDetailFeature>
    
    var body: some View {
        Form {
            Button("Delete") {
                store.send(.deleteButtonTapped)
            }
        }
        .navigationBarTitle(Text(store.contact.name))
        .alert($store.scope(state: \.alert, action: \.alert))
    }
}
