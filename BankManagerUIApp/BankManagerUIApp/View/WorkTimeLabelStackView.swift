//
//  WorkTimeLabelStackView.swift
//  BankManagerUIApp

import UIKit

class WorkTimeLabelStackView: UIStackView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "업무시간 -"
        label.textAlignment = .right
        return label
    }()
    
    private let workTimeLabel: UILabel = {
        let label = UILabel()
        label.text = " 00:00:000"
        label.textAlignment = .left
        return label
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
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(workTimeLabel)
    }
    
    func updateWorkTimeLabel(input: String) {
        workTimeLabel.text = input
    }
}
