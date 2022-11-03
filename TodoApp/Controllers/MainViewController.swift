//
//  ViewController.swift
//  TodoApp
//
//  Created by Олег Борисов on 04.11.2022.
//

import UIKit

class MainViewController: UIViewController {

    weak var addTodoViewController: AddTodoViewController?

    var todoList = [TodoList]()

    private var collectionViewTodoList: UICollectionView?


    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width/3.2 , height: view.frame.size.height/6.2)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        collectionViewTodoList = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewTodoList?.register(MainHeaderCollectionReusableView.self,
                                         forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                         withReuseIdentifier: MainHeaderCollectionReusableView.identifier)
        collectionViewTodoList?.register(TodoTableCollectionViewCell.self, forCellWithReuseIdentifier: TodoTableCollectionViewCell.identifier)
        collectionViewTodoList?.delegate = self
        collectionViewTodoList?.dataSource = self

        collectionViewTodoList?.backgroundColor = .systemBackground.withAlphaComponent(0.99)
        view.addSubview(collectionViewTodoList!)

        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        collectionViewTodoList?.addGestureRecognizer(gesture)

        fetchLocalStorageForDownload()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("addTodo"), object: nil, queue: nil) { _ in
            self.fetchLocalStorageForDownload()
        }
        

    }

    private func fetchLocalStorageForDownload(){
        DataPersistanceManager.shared.fetchTodoList { [weak self] result in
            switch result{
                case .success(let todoList):
                    self?.todoList = todoList
                    DispatchQueue.main.async {
                        self?.collectionViewTodoList?.reloadData()
                        print(todoList)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }

    @objc func handleLongPressGesture( _ gesture: UILongPressGestureRecognizer){
            guard let collectionView = collectionViewTodoList else{
                return
            }
            switch gesture.state{
                case .began:
                    guard let targetIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else { return }
                    collectionView.beginInteractiveMovementForItem(at: targetIndexPath)
                case .changed:
                    collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
                case .ended:
                    collectionView.endInteractiveMovement()
                default:
                    collectionView.cancelInteractiveMovement()
            }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionViewTodoList?.frame = view.bounds
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todoList.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodoTableCollectionViewCell.identifier, for: indexPath) as? TodoTableCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        cell.backgroundColor = .white
        
        switch indexPath.row{
            case let index where index == todoList.count:
                cell.configureCreateButton()
                cell.layer.borderColor = UIColor.gray.cgColor
                return cell
            default:
                cell.configureTaskCell(with: Todo(title: "Test Task", colorTitle: "red"))
                cell.layer.borderColor = UIColor.gray.cgColor
                return cell
        }

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: view.frame.size.width/3.2 , height: view.frame.size.height/6.2)
    }

    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return indexPath.row != todoList.count
    }

    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard destinationIndexPath.row != todoList.count else { return }
        let item = todoList.remove(at: sourceIndexPath.row)
        todoList.insert(item, at: destinationIndexPath.row)

    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                     withReuseIdentifier: MainHeaderCollectionReusableView.identifier,
                                                                      for: indexPath) as! MainHeaderCollectionReusableView
        header.configure()
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        switch indexPath.row{
            case let index where index == todoList.count:
                let vc = UINavigationController(rootViewController: AddTodoViewController())
                self.present(vc, animated: true)
            default:
                let todoList = todoList[indexPath.row]
//                DataPersistanceManager.shared.fetchTodoTasks(todoList: todoList) {[weak self] result in
//                    switch result{
//                        case .success(let todoTask):
//                            let taskItem = todoTask[indexPath.row]
//                            let viewModel = TodoTasksViewModel(title: taskItem.title!, isDone: taskItem.isDone, todoList: todoList)
//                        case .failure(let error):
//                            print(error.localizedDescription)
//                    }
//            }
        }
    }
}


