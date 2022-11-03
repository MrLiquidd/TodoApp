//
//  MainHeaderCollectionReusableView.swift
//  TodoApp
//
//  Created by Олег Борисов on 06.11.2022.
//

import UIKit

class MainHeaderCollectionReusableView: UICollectionReusableView {

    static let identifier = "MainHeaderCollectionReusabelView"

    private let label: UILabel = {
        var label = UILabel()
        label.text = "Todo List!"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()

    public func configure(){
        addSubview(label)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
        
}
