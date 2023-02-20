//
//  QueueLabelStackView.swift
//  BankManagerUIApp

import UIKit

class QueueLabelStackView: UIStackView {
    private let waitingLabel: UILabel = {
        let label = UILabel()
        label.text = "대기중"
        label.backgroundColor = .systemGreen
        label.textColor = .white
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()
    
    private let workingLabel: UILabel = {
        let label = UILabel()
        label.text = "업무중"
        label.backgroundColor = .systemIndigo
        label.textColor = .white
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title1)
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
        self.addArrangedSubview(waitingLabel)
        self.addArrangedSubview(workingLabel)
    }
}
