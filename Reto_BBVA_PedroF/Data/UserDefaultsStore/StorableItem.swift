//
//  StorableItem.swift
//  Reto_BBVA_PedroF
//
//  Created by Macky on 22/07/25.
//

import Foundation

protocol StorableItem: Codable, Identifiable, Equatable where ID: Codable & Equatable {}
