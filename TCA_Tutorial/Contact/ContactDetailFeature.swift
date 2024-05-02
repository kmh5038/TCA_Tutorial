//
//  ContactDetailFeature.swift
//  TCA_Tutorial
//
//  Created by 김명현 on 4/3/24.
//

import ComposableArchitecture

@Reducer
struct ContactDetailFeature {
  @ObservableState
  struct State: Equatable {
    @Presents var alert: AlertState<Action.Alert>?
    let contact: Contact
  }
  enum Action {
    case alert(PresentationAction<Alert>)
    case delegate(Delegate)
      case deleteButtonTapped(id: Contact.ID)
      
      enum Alert: Equatable {
        case confirmDeletion(id:Contact.ID)
    }
      
    enum Delegate {
      case confirmDeletion
    }
  }
    
  @Dependency(\.dismiss) var dismiss
    
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .alert(.presented(.confirmDeletion)):
        return .run { send in
          await send(.delegate(.confirmDeletion))
          await self.dismiss()
        }
      case .alert:
        return .none
      case .delegate:
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
      }
    }
    .ifLet(\.$alert, action: \.alert)
  }
}




