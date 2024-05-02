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
        @Presents var addContact: AddContactFeature.State?
        @Presents var alert: AlertState<Action.Alert>?
        var contacts: IdentifiedArrayOf<Contact> = []
        var path = StackState<ContactDetailFeature.State>()
    }
    
    enum Action {
        case addButtonTapped
        case addContact(PresentationAction<AddContactFeature.Action>)
        case alert(PresentationAction<Alert>)
        case deleteButtonTapped(id: Contact.ID)
        case path(StackAction<ContactDetailFeature.State, ContactDetailFeature.Action>)
        
        enum Alert: Equatable {
            case confirmDeletion(id:Contact.ID)
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                state.addContact = AddContactFeature.State(contact: Contact(id: UUID(), name: ""))
                return .none
                
//            case .addContact(.presented(.delegate(.cancel))): (dismiss 사용하면서 필요없어짐)
//                state.addContact = nil
//                return .none
                
            case let .addContact(.presented(.delegate(.saveContact(contact)))):
                state.contacts.append(contact)
//                state.addContact = nil (dismiss 사용하면서 필요없어짐)
                return .none
        
            case .addContact:
                return .none
                
            case .alert(.presented(.confirmDeletion(id: let id))):
                state.contacts.remove(id: id)
                return .none
                
            case .alert:
                return .none
                
            case .deleteButtonTapped(id: let id):
                state.alert = AlertState {
                    TextState("Are you sure?")
                } actions: {
                    ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
                        TextState("Delete")
                    }
                }
                return .none
            
            case let .path(.element(id: id, action: .delegate(.confirmDeletion))):
                guard let detailState = state.path[id: id] else { return .none }
                state.contacts.remove(id: detailState.contact.id)
                return .none
            
            case .path:
                return .none
            }
        }
        .ifLet(\.$addContact, action: \.addContact) {
            AddContactFeature()
        }
        .forEach(\.path, action: \.path) {
            ContactDetailFeature()
        }
        .ifLet(\.$alert, action: \.alert)
    }
}

