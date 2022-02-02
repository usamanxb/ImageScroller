//
//  File.swift
//  
//
//  Created by Usama Ali on 01/02/2022.
//

import SwiftUI
public extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
