//
//  NumberBO.swift
//  Numbers Light
//
//  Created by El Mahdi Boukhris on 25/06/2022.
//

import Foundation

// MARK: - ImageHit
struct NumberBO: Codable, Equatable {
    let name: String?
    let text: String?
    let image: String?

    static func == (lhs: NumberBO, rhs: NumberBO) -> Bool {
        return (lhs.name == rhs.name)
    }
}

typealias Numbers = [NumberBO]
