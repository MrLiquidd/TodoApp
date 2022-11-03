//
//  ColorsTableViewCell.swift
//  TodoApp
//
//  Created by Олег Борисов on 09.11.2022.
//

import UIKit

class ColorsTableViewCell: UITableViewCell{


    static let identificator = "ColorsTableViewCell"

    private let colors: [UIColor] = [
        UIColor.systemPurple,
        UIColor.systemBlue,
        UIColor.systemYellow,
        UIColor.cyan,
        UIColor.orange,
        UIColor.systemRed,
        UIColor.systemGreen,
        UIColor.purple
    ]

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ColorsCollectionViewCell.self, forCellWithReuseIdentifier: ColorsCollectionViewCell.identifier)
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }

    func configure(){

    }

}

extension ColorsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorsCollectionViewCell.identifier, for: indexPath) as? ColorsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .systemBackground

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ColorsCollectionViewCell else {return}
        let color = colors[indexPath.row]
        cell.configure(with: color)
    }

}
