//
//  Color+Extensions.swift
//  NewsApp
//
//  Created by Nilaakash Singh on 19/11/2021.
//

import SwiftUI

extension Color {
    static func random() -> Color {
        return Color(red: .random(in: 0...1), green: .random(in: 0...1), blue:  .random(in: 0...1))
    }
}
