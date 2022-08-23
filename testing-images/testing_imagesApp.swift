//
//  testing_imagesApp.swift
//  testing-images
//
//  Created by Alex Little on 23/08/2022.
//

import SwiftUI
import ComposableArchitecture

@main
struct testing_imagesApp: App {
    let store = Store(
        initialState: AppState(),
        reducer: appReducer,
        environment: ()
    )
    var body: some Scene {
        WindowGroup {
            MidView(
                store: store.scope(state: \.one, action: AppAction.one),
                content: { store in
                    MidView(
                        store: store.scope(state: \.two, action: ActionOne.two),
                        content: { store in
                            MidView(
                                store: store.scope(state: \.three, action: ActionTwo.three),
                                content: { store in
                                    MidView(
                                        store: store.scope(state: \.four, action: ActionThree.four),
                                        content: { store in
                                            MidView(
                                                store: store.scope(state: \.five, action: ActionFour.five),
                                                content: { store in
                                                    MidView(
                                                        store: store.scope(state: \.six, action: ActionFive.six),
                                                        content: { store in
                                                            ContentView(store: store.scope(state: \.seven, action: ActionSix.seven))
                                                        }
                                                    )
                                                }
                                            )
                                        }
                                    )
                                }
                            )
                        }
                    )
                }
            )
        }
    }
}

struct MidView<State: Equatable, Action: Equatable, Content: View>: View {
    let store: Store<State, Action>
    let content: Content

    init(store: Store<State, Action>, @ViewBuilder content: (Store<State, Action>) -> Content) {
        self.store = store
        self.content = content(store)
    }
    
    var body: some View {
        content
    }
}
