//
//  UserTopButtonStackView.swift
//  BankManagerUIApp

import UIKit

final class UserTopButtonStackView: UIStackView {
    private let addCustomerButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .preferredFont(forTextStyle: .body)
        button.setTitle("고객 10명 추가", for: .normal)
        return button
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .preferredFont(forTextStyle: .body)
        button.setTitle("초기화", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
        addSubViews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureStackView() {
        axis = .horizontal
        distribution = .fillEqually
    }
    
    private func addSubViews() {
        self.addArrangedSubview(addCustomerButton)
        self.addArrangedSubview(resetButton)
    }
}
