//
//  TodoList+CoreDataProperties.swift
//  TodoApp
//
//  Created by Олег Борисов on 06.11.2022.
//
//

import Foundation
import CoreData


extension TodoList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoList> {
        return NSFetchRequest<TodoList>(entityName: "TodoList")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var color: String?
    @NSManaged public var todoItems: NSSet?

}

// MARK: Generated accessors for todoItems
extension TodoList {

    @objc(addTodoItemsObject:)
    @NSManaged public func addToTodoItems(_ value: TodoTasks)

    @objc(removeTodoItemsObject:)
    @NSManaged public func removeFromTodoItems(_ value: TodoTasks)

    @objc(addTodoItems:)
    @NSManaged public func addToTodoItems(_ values: NSSet)

    @objc(removeTodoItems:)
    @NSManaged public func removeFromTodoItems(_ values: NSSet)

}

extension TodoList : Identifiable {

}
