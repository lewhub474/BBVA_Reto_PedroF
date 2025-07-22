//
//  SpyToggleBookmarkUseCase.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 22/07/25.
//
import XCTest
@testable import Reto_BBVA_PedroF

final class SpyToggleBookmarkUseCase: UseCase {
   
    var spyCounter: Int = 0
    
    func execute(_ id: Int) -> Any? {
       spyCounter += 1
    }
}
