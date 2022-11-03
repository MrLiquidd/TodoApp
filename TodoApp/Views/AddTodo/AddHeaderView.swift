//
//  AddHeaderView.swift
//  TodoApp
//
//  Created by Олег Борисов on 09.11.2022.
//

import UIKit

class AddHeaderView: UIView {

    static let identifier = "AddHeaderView"

    private let label: UITextField = {
        var label = UITextField()
        label.placeholder = "CATEGORY NAME"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}
