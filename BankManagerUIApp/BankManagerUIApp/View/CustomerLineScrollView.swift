//
//  CustomerLineScrollView.swift
//  BankManagerUIApp
//
//  Copyright (c) 2022 Minii All rights reserved.

import UIKit

class CustomerLineScrollView: UIScrollView, UIScrollViewDelegate {
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        delegate = self
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    func inputCustomer(customer: Customer) {
        let business = customer.business
        let ticketNumber = customer.ticketNumber.description
        
        DispatchQueue.main.async {
            let label = UILabel()
            label.text = "\(ticketNumber) - \(business.rawValue)"
            label.textAlignment = .center
            label.tag = customer.ticketNumber
            
            switch business {
            case .deposit:
                label.textColor = .label
            case .loans:
                label.textColor = .systemPurple
            }
            
            self.contentStackView.addArrangedSubview(label)
        }
    }
    
    func popCustomer(customer: Customer) {
        DispatchQueue.main.async {
            guard let contents = self.contentStackView.arrangedSubviews as? [UILabel] else {
                return
            }
            
            guard let content = contents.filter({ $0.tag == customer.ticketNumber }).first else {
                return
            }
            
            content.removeFromSuperview()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
}
	
