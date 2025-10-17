//
//  StatefulViewModel.swift
//  ThronesApp
//
//  Created by Diggo Silva on 16/10/25.
//

import Combine

protocol StatefulViewModel {
    associatedtype State
    var statePublisher: AnyPublisher<State, Never> { get }
}
