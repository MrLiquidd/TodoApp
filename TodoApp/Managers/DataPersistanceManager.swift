//
//  DataPersistanceManager.swift
//  TodoApp
//
//  Created by Олег Борисов on 06.11.2022.
//

import Foundation
import UIKit
import CoreData


class DataPersistanceManager{
    static let shared = DataPersistanceManager()

    enum DatabaseError: Error{
        case failureToSaveData
        case failureToDeleteData
        case failureToFetchData
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataRelationship")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    //Core Data Saving support
    func save () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func addTodoList(todo: Todo, completion: @escaping(Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let item = TodoList(context: context)
        item.title = todo.title
        item.color = todo.color?.toHexString()
        do{
            try context.save()
            completion(.success(()))
        } catch{
            completion(.failure(DatabaseError.failureToSaveData))
        }

    }
    func addTodoTasks(todoTask: TodoTask, todoList: TodoList){
        let tasks = TodoTasks(context: persistentContainer.viewContext)
        tasks.isDone = todoTask.isDone
        tasks.titleItem = todoTask.title
        todoList.addToTodoItems(tasks)

    }
    func fetchTodoList(completion: @escaping (Result<[TodoList], Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<TodoList>
        request = TodoList.fetchRequest()
        do {
            let todoList = try context.fetch(request)
            completion(.success(todoList))
        } catch {
            completion(.failure(DatabaseError.failureToFetchData))
        }
    }
    func fetchTodoTasks(todoList: TodoList, completion: @escaping (Result<[TodoTasks], Error>)->Void){
        let request: NSFetchRequest<TodoTasks> = TodoTasks.fetchRequest()
        request.predicate = NSPredicate(format: "todoList = %@", todoList)
        request.sortDescriptors = [NSSortDescriptor(key: "titleItem", ascending: false)]
        do{
            var fetchedTodoTasks: [TodoTasks] = []
            fetchedTodoTasks = try persistentContainer.viewContext.fetch(request)
            completion(.success(fetchedTodoTasks))
        } catch{
            completion(.failure(DatabaseError.failureToFetchData))
        }
    }

    func deleteTodoList(todoList: TodoList){
        let context = persistentContainer.viewContext
        context.delete(todoList)
        save()
    }
    func deleteTodoTasks(todoTasks: TodoTasks){
        let context = persistentContainer.viewContext
        context.delete(todoTasks)
        save()
    }
}
