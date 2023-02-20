//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

final class BankView: UIView {
    private let userTopButtonView = UserTopButtonStackView()
    private let workTimeLabel = WorkTimeLabelStackView()
    private let queueLabel = QueueLabelStackView()
    
    private let waitingLineScrollView = CustomerLineScrollView()
    private let workingLineScrollView = CustomerLineScrollView()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addStackView()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addStackView() {
        [
            waitingLineScrollView,
            workingLineScrollView
        ].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    private func configureUI() {
        backgroundColor = .systemBackground
        addSubViews()
        makeConstraintTopButtonView()
        makeConstraintWorkTimeLabel()
        makeConstraintQueueLabel()
//        makeConstraintStackView()
        makeConstraintWaitingView()
        makeConstraintWorkingView()
    }
    
    private func addSubViews() {
        [
            userTopButtonView,
            workTimeLabel,
            queueLabel,
//            stackView
            waitingLineScrollView,
            workingLineScrollView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    private func makeConstraintTopButtonView() {
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            userTopButtonView.leadingAnchor.constraint(equalTo: leadingAnchor),
            userTopButtonView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            userTopButtonView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func makeConstraintWorkTimeLabel() {
        NSLayoutConstraint.activate([
            workTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            workTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            workTimeLabel.topAnchor.constraint(equalTo: userTopButtonView.bottomAnchor, constant: 8)
        ])
    }
    
    private func makeConstraintQueueLabel() {
        NSLayoutConstraint.activate([
            queueLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            queueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            queueLabel.topAnchor.constraint(equalTo: workTimeLabel.bottomAnchor, constant: 8)
        ])
    }
    
//    private func makeConstraintStackView() {
//        NSLayoutConstraint.activate([
//            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            stackView.topAnchor.constraint(equalTo: queueLabel.bottomAnchor),
//            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
//        ])
//    }
    
    private func makeConstraintWaitingView() {
        NSLayoutConstraint.activate([
            waitingLineScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            waitingLineScrollView.trailingAnchor.constraint(equalTo: centerXAnchor),
            waitingLineScrollView.topAnchor.constraint(equalTo: queueLabel.bottomAnchor),
            waitingLineScrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func makeConstraintWorkingView() {
        NSLayoutConstraint.activate([
            workingLineScrollView.leadingAnchor.constraint(equalTo: centerXAnchor),
            workingLineScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            workingLineScrollView.topAnchor.constraint(equalTo: queueLabel.bottomAnchor),
            workingLineScrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func requireUpdateTime(input: String) {
        workTimeLabel.updateWorkTimeLabel(input: input)
    }
    
    func addNewCustomerView(customer: Customer) {
        waitingLineScrollView.inputCustomer(customer: customer)
    }
    
    func popNewCustomerView(customer: Customer) {
        waitingLineScrollView.popCustomer(customer: customer)
    }
    
    func addNewWorkingCustomerView(customer: Customer) {
        workingLineScrollView.inputCustomer(customer: customer)
    }
    
    func popWorkingCustomerView(customer: Customer) {
        workingLineScrollView.popCustomer(customer: customer)
    }
}
