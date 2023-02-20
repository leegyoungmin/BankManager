//
//  BankOperationProcessing.swift
//  BankManagerConsoleApp
//
//  Copyright (c) 2022 Minii All rights reserved.

import Foundation

enum notificationName {
    static let start = Notification.Name(rawValue: "start")
    static let end = Notification.Name(rawValue: "end")
}

protocol BankOperationProcessing {
    var customer: Customer { get }
    
    func work(customer: Customer)
}

extension BankOperationProcessing {
    func work(customer: Customer) {
        NotificationCenter.default.post(
            name: notificationName.start,
            object: customer
        )
        
        Thread.sleep(forTimeInterval: customer.business.businessTime)
        
        NotificationCenter.default.post(
            name: notificationName.end,
            object: customer
        )
    }
}
