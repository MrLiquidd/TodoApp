//
//  CustomColor.swift
//  TodoApp
//
//  Created by Олег Борисов on 10.11.2022.
//

import UIKit

enum customColor {
    case colorOne
    case colorTwo
    case colorThree
    case colorFour
    case colorFive
    case colorSix
    case colorSeven
    case colorEight
    case colorNine

    var myCustomColor: UIColor! {
        switch self {
            case .colorOne:
                return UIColor.systemRed
            case .colorTwo:
                return UIColor.systemPurple
            case .colorThree:
                return UIColor.systemBlue
            case .colorFour:
                return UIColor.systemGreen
            case .colorFive:
                return UIColor.systemOrange
            case .colorSix:
                return UIColor.systemYellow
            case .colorSeven:
                return UIColor.systemCyan
            case .colorEight:
                return UIColor.systemPink
            case .colorNine:
                return UIColor.systemMint
        }

    }
}
