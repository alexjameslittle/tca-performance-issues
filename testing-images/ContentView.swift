//
//  ContentView.swift
//  testing-images
//
//  Created by Alex Little on 23/08/2022.
//

import SwiftUI
import ComposableArchitecture

struct ChildView: View {
    let store: Store<ChildState, ChildAction>

    var body: some View {
        ZStack {
            WithViewStore(store.scope(state: \.color)) { viewStore in
                Color(uiColor: viewStore.state)
                    .frame(width: 10, height: 10)
            }
        }
        .onAppear {
            let viewStore = ViewStore(store)
            viewStore.send(.onAppear)
        }
        .onDisappear {
            let viewStore = ViewStore(store)
            viewStore.send(.onDisappear)
        }
    }
}

struct ContentView: View {
    let store: Store<StateSeven, ActionSeven>
    
    var body: some View {
        List {
            ForEachStore(store.scope(state: \.children, action: ActionSeven.child)) { childStore in
                ChildView(store: childStore)
            }
        }
    }
}
