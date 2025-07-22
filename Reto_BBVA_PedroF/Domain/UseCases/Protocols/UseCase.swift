//
//  UseCase.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 22/07/25.
//

protocol UseCase<Input, Output> {
    associatedtype Input
    associatedtype Output

    @discardableResult
    func execute(_ input: Input) -> Output
}
