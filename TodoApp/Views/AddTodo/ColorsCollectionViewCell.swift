//
//  ColorsCollectionViewCell.swift
//  TodoApp
//
//  Created by Олег Борисов on 09.11.2022.
//

import UIKit

class ColorsCollectionViewCell: UICollectionViewCell {

    static var identifier = "ColorsCollectionViewCell"

    private var colorImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "circle")
        imageView.image = image
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(colorImageView)
        contentView.backgroundColor = .systemBackground
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        colorImageView.frame = contentView.bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with color: UIColor){
        colorImageView.backgroundColor = .systemBackground
        colorImageView.tintColor = color
    }
    
}
