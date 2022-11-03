//
//  TodoTableCollectionViewCell.swift
//  TodoApp
//
//  Created by Олег Борисов on 06.11.2022.
//

import UIKit

class TodoTableCollectionViewCell: UICollectionViewCell {

    static let identifier = "TodoTableCollectionViewCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let labelOfTask: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let labelCountTask: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(labelOfTask)
        contentView.addSubview(labelCountTask)

        applyConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func applyConstraints(){
        let imageViewConstraint = [
            contentView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 30)
        ]
        let labelOfTaskConstraint = [
            labelOfTask.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            labelOfTask.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 10),

        ]
        let labelCountTaskConstraint = [
            labelCountTask.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            labelCountTask.topAnchor.constraint(equalTo: labelOfTask.bottomAnchor, constant: 5),
        ]

        NSLayoutConstraint.activate(imageViewConstraint)
        NSLayoutConstraint.activate(labelOfTaskConstraint)
        NSLayoutConstraint.activate(labelCountTaskConstraint)
    }

    public func configureTaskCell(with model: Todo){
        labelOfTask.text = model.title
        let image = UIImage(systemName: "circle")
        imageView.tintColor = model.color ?? .black
        imageView.image = image
    }

    public func configureCreateButton(){
        labelOfTask.text = "Create Task"
        //labelCountTask cкрыть
        let image = UIImage(systemName: "plus")
        image?.withTintColor(.black)
        imageView.image = image
    }
}
