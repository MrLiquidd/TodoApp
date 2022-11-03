//
//  AddTodoViewController.swift
//  TodoApp
//
//  Created by Олег Борисов on 07.11.2022.
//

import UIKit

class AddTodoViewController: UIViewController, ButtonBackgroundColorProtocol{

    var selectedProject: TodoList?
    let colorGrid = ColorGrid()
    var dataMenager: DataPersistanceManager?
    var getColorFromColorGrid: String? = nil

    private let setProjectName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Category Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemBackground
        //        textfield.layer.cornerRadius = 7
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 35)
        return textField
    }()

    let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupColorGrid()
        editProjectSetup()
        addProjectName()
        addSaveButton()
        addNavBar()
    }

    internal func getButtonColor(buttonColor: UIColor){
        getColorFromColorGrid = buttonColor.toHexString()
    }

    internal func editProjectSetup(){
        if selectedProject != nil{
            setProjectName.text = selectedProject?.title
            getColorFromColorGrid = selectedProject?.color
            self.title = "Edit \(selectedProject?.title ?? "Unnamed")"
            saveButton.setTitle("Update", for: .normal)
            colorGrid.checkMatchAndHighlight(with: UIColor(named: (selectedProject?.color)!)!)
        } else{
            self.title = "Create a new Project"
        }
    }

    private func addNavBar(){
        let closeXButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonTapped))
        self.navigationItem.rightBarButtonItem = closeXButton
    }
    @objc func closeButtonTapped(){
        dismiss(animated: true)
    }

    private func setupColorGrid(){
        view.addSubview(colorGrid)
        colorGrid.delegate = self

        NSLayoutConstraint.activate([
            colorGrid.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            colorGrid.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            colorGrid.heightAnchor.constraint(equalToConstant: self.view.frame.width / 1.65),
            colorGrid.widthAnchor.constraint(equalToConstant: self.view.frame.width / 1.65)
        ])
    }

    private func addProjectName(){
        view.addSubview(setProjectName)

        NSLayoutConstraint.activate([
            setProjectName.bottomAnchor.constraint(equalTo: self.colorGrid.topAnchor, constant: -50),
            setProjectName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    private func addSaveButton() {
        view.addSubview(saveButton)
        self.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: self.colorGrid.bottomAnchor, constant: 70),
            saveButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45),
            saveButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45),
            saveButton.heightAnchor.constraint(equalToConstant: 60)
            //            self.saveButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }

    private func checkAreFieldsEmpty() -> Bool{
        if setProjectName.text == ""{
            setProjectName.layer.borderWidth = 2
            setProjectName.layer.cornerRadius = 7
            setProjectName.layer.borderColor  = UIColor.red.cgColor
            setProjectName.placeholder = "Needs Title!"
        } else{
            setProjectName.layer.borderWidth = 0
            setProjectName.layer.borderColor = UIColor.clear.cgColor
            setProjectName.borderStyle = .roundedRect
        }

        if getColorFromColorGrid == nil{
            let alert = UIAlertController(title: "Select a color!", message: "Progect needs a color", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            self.present(alert, animated: true)
        }
        if setProjectName.text != "" && getColorFromColorGrid != nil {
            return false
        }
        return true
    }

    @objc func saveButtonTapped(){
        if !checkAreFieldsEmpty(){
            if selectedProject != nil{
                selectedProject?.setValue(setProjectName.text, forKey: #keyPath(TodoList.title))
                selectedProject?.setValue(self.getColorFromColorGrid, forKey: #keyPath(TodoList.color))
                dataMenager?.save()
            } else{
                print(getColorFromColorGrid!)
                DataPersistanceManager.shared.addTodoList(todo: Todo(title: setProjectName.text!, colorTitle: getColorFromColorGrid!)) { result in
                    switch result{
                        case .success():
                            NotificationCenter.default.post(name: NSNotification.Name("addTodo"), object: nil)
                        case .failure(let error):
                            print(error.localizedDescription)
                    }
                }
            }
            dismiss(animated: true)

        }
    }

}
