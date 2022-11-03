//
//  Todo.swift
//  TodoApp
//
//  Created by Олег Борисов on 06.11.2022.
//

import Foundation
import UIKit


struct Todo: Codable{
    var title: String
    var colorTitle:String

    var color: UIColor?{
        return StickerColor(rawValue: colorTitle)?.color
    }
}
enum StickerColor:String{
    case red, blue

    var color:UIColor{
        switch self{
            case .red:
                return .systemRed
            default:
                return .systemBlue
        }
    }
}
