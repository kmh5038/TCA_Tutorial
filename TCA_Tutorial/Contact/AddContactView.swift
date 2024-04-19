//
//  AddContactView.swift
//  TCA_Tutorial
//
//  Created by 김명현 on 3/29/24.
//

import ComposableArchitecture
import SwiftUI


struct AddContactView: View {
   @Binding var store: StoreOf<AddContactFeature>
    
    var body: some View {
        Form {
            TextField("Name", text: $store.contact.name.sending(\.setName))
        }
        .toolbar {
            ToolbarItem {
                Button("Cancel") {
                    store.send(.cancelButtonTapped)
                }
            }
        }
    }
}



