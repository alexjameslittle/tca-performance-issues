//
//  TCA.swift
//  testing-images
//
//  Created by Alex Little on 23/08/2022.
//

import Foundation
import ComposableArchitecture
import SwiftUI

let cachedChildren: IdentifiedArrayOf<ChildState> = .init(uniqueElements: (0..<10000).map { .init(id: "\($0)") })

struct AppState: Equatable {
    var one: StateOne = .init()
}

enum AppAction: Equatable {
    case one(ActionOne)
}

let appReducer = Reducer<AppState, AppAction, Void> { state, action, _ in
    switch action {
    case .one:
        break
    }
    return .none
}
    .combined(with:
                reducerOne
        .pullback(
            state: \.one,
            action: /AppAction.one,
            environment: { $0 }
        )
    )

struct StateOne: Equatable {
    var two: StateTwo = .init()
}

enum ActionOne: Equatable {
    case two(ActionTwo)
}

let reducerOne = Reducer<StateOne, ActionOne, Void> { state, action, _ in
    switch action {
    case .two:
        break
    }
    return .none
}
    .combined(with:
                reducerTwo
        .pullback(
            state: \.two,
            action: /ActionOne.two,
            environment: { $0 }
        )
    )

struct StateTwo: Equatable {
    var three: StateThree = .init()
}

enum ActionTwo: Equatable {
    case three(ActionThree)
}

let reducerTwo = Reducer<StateTwo, ActionTwo, Void> { state, action, _ in
    switch action {
    case .three:
        break
    }
    return .none
}
    .combined(with:
                reducerThree
        .pullback(
            state: \.three,
            action: /ActionTwo.three,
            environment: { $0 }
        )
    )

struct StateThree: Equatable {
    var four: StateFour = .init()
}

enum ActionThree: Equatable {
    case four(ActionFour)
}

let reducerThree = Reducer<StateThree, ActionThree, Void> { state, action, _ in
    switch action {
    case .four:
        break
    }
    return .none
}
    .combined(with:
                reducerFour
        .pullback(
            state: \.four,
            action: /ActionThree.four,
            environment: { $0 }
        )
    )

struct StateFour: Equatable {
    var five: StateFive = .init()
}

enum ActionFour: Equatable {
    case five(ActionFive)
}

let reducerFour = Reducer<StateFour, ActionFour, Void> { state, action, _ in
    switch action {
    case .five:
        break
    }
    return .none
}
    .combined(with:
                reducerFive
        .pullback(
            state: \.five,
            action: /ActionFour.five,
            environment: { $0 }
        )
    )

struct StateFive: Equatable {
    var six: StateSix = .init()
}

enum ActionFive: Equatable {
    case six(ActionSix)
}

let reducerFive = Reducer<StateFive, ActionFive, Void> { state, action, _ in
    switch action {
    case .six:
        break
    }
    return .none
}
    .combined(with:
                reducerSix
        .pullback(
            state: \.six,
            action: /ActionFive.six,
            environment: { $0 }
        )
    )

struct StateSix: Equatable {
    var seven: StateSeven = .init()
}

enum ActionSix: Equatable {
    case seven(ActionSeven)
}

let reducerSix = Reducer<StateSix, ActionSix, Void> { state, action, _ in
    switch action {
    case .seven:
        break
    }
    return .none
}
    .combined(with:
                reducerSeven
        .pullback(
            state: \.seven,
            action: /ActionSix.seven,
            environment: { $0 }
        )
    )

struct StateSeven: Equatable {
    var children: IdentifiedArrayOf<ChildState> = cachedChildren
}

enum ActionSeven: Equatable {
    case child(id: String, action: ChildAction)
}

let reducerSeven = Reducer<StateSeven, ActionSeven, Void> { state, action, _ in
    switch action {
    case .child:
        break
    }
    return .none
}
    .combined(
        with: childReducer
            .forEach(
                state: \.children,
                action: /ActionSeven.child,
                environment: { $0 }
            )
    )

struct ChildState: Identifiable, Equatable {
    let id: String
    
    var color: UIColor = .random
}

enum ChildAction: Equatable {
    case onAppear
    case onDisappear
}

let childReducer = Reducer<ChildState, ChildAction, Void> { state, action, _ in
    switch action {
    case .onAppear:
        state.color = .random
    case .onDisappear:
        state.color = .random
    }
    return .none
}


extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1
        )
    }
}

