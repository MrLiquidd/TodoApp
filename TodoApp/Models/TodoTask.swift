//
//  Todo.swift
//  TodoApp
//
//  Created by Олег Борисов on 06.11.2022.
//

import Foundation

struct TodoTask: Codable{
    var title: String
    var isDone: Bool = false
}
