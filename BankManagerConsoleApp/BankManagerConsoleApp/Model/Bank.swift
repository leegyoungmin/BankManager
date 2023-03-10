//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Copyright (c) 2022 Zhilly, Minii All rights reserved.

import Foundation

class Bank {
    private var customerQueue: CustomerQueue<Customer>?
    
    private var isQueueEmpty: Bool {
        return customerQueue?.isEmpty ?? true
    }
    
    func createQueue() {
        customerQueue = CustomerQueue()
    }
    
    func addCustomer(customer: Customer) {
        customerQueue?.enqueue(value: customer)
    }
    
    func startWork() {
        let waitingLines = setUpWaitingLine()
        
        var userCount = 0
        
        while !isQueueEmpty {
            guard let customer = customerQueue?.dequeue() else {
                return
            }
            
            let customerOperation = BankerOperation(customer: customer)
            
            customerOperation.completionBlock = {
                userCount += 1
            }
            
            switch customer.business {
            case .deposit:
                waitingLines.depositQueue.addOperation(customerOperation)
            case .loans:
                waitingLines.loansQueue.addOperation(customerOperation)
            }
        }
    }
    
    func resetCustomerQueue() {
        customerQueue?.clear()
        customerQueue = nil
    }
}

private extension Bank {
    func setUpWaitingLine() -> (depositQueue: OperationQueue, loansQueue: OperationQueue) {
        let depositQueue = OperationQueue()
        let loansQueue = OperationQueue()
        
        depositQueue.maxConcurrentOperationCount = 2
        loansQueue.maxConcurrentOperationCount = 1
        
        return (depositQueue, loansQueue)
    }
}
