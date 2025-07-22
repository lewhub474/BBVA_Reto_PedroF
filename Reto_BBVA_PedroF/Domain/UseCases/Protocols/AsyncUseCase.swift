//
//  AsyncUseCase.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 22/07/25.
//

protocol AsyncUseCase<Input, Output> {
    associatedtype Input
    associatedtype Output

    func execute(_ input: Input) async throws -> Output
}
