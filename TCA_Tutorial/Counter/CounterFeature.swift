//
//  CounterFeature.swift
//  TCA_Tutorial
//
//  Created by 김명현 on 3/27/24.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct CounterFeature {
    @ObservableState
    struct State: Equatable {
        var count = 0
        var fact: String?
        var isLoding = false
        var isTimerRunning = false
    }
    
    enum Action {
        case decrementButtonTapped
        case factButtonTapped
        case incrementButtonTapped
        case setFact(String)
        case timerButtonTapped
    }
    
    enum CancelID { case timer }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .decrementButtonTapped:
                state.count -= 1
                return .none
            case .factButtonTapped:
                state.isLoding.toggle()
                
                return .run { [count = state.count] send in
                    guard let url = URL(string: "http://numbersapi.com/\(count)") else {
                        print("Invalid URL")
                        return
                    }
                    do {
                        let (data,_) = try await URLSession.shared.data(from: url)
                        let fact = String(decoding: data, as: UTF8.self)
                        await send(.setFact(fact))
                    } catch {
                        print("Error fetching data:\(error)")
                    }
                }
                
            case .incrementButtonTapped:
                state.count += 1
                return .none
                
            case let .setFact(fact):
                state.fact = fact
                state.isLoding.toggle()
                return .none
                
            case .timerButtonTapped:
                state.isTimerRunning.toggle()
                if state.isTimerRunning {
                    return .run { send in
                        while true {
                            try await Task.sleep(for: .seconds(1))
                            await send(.incrementButtonTapped)
                        }
                    }
                    .cancellable(id: CancelID.timer)
                } else {
                    return .cancel(id: CancelID.timer)
                }
            }
        }
    }
}

