//
//  TodoTasks+CoreDataProperties.swift
//  TodoApp
//
//  Created by Олег Борисов on 06.11.2022.
//
//

import Foundation
import CoreData


extension TodoTasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoTasks> {
        return NSFetchRequest<TodoTasks>(entityName: "TodoTasks")
    }

    @NSManaged public var isDone: Bool
    @NSManaged public var titleItem: String?
    @NSManaged public var todolist: TodoList?

}
