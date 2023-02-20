//
//  BankViewController.swift
//  BankManagerUIApp
//
//  Copyright (c) 2022 Minii All rights reserved.
        
import UIKit

typealias ReportData = (customerCount: Int, duringTime: TimeInterval)

class BankViewController: UIViewController {
    let bankView = BankView()
    let bank: Bank = Bank()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = bankView
        openBank()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didReceiveStartCustomer(_:)),
            name: notificationName.start,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didReceiveEndCustomer(_:)),
            name: notificationName.end,
            object: nil
        )
    }
    
    @objc func didReceiveStartCustomer(_ noti: Notification) {
        guard let customer = noti.object as? Customer else {
            return
        }
        
        bankView.popNewCustomerView(customer: customer)
        bankView.addNewWorkingCustomerView(customer: customer)
    }
    
    @objc func didReceiveEndCustomer(_ noti: Notification) {
        guard let customer = noti.object as? Customer else {
            return
        }
        
        bankView.popWorkingCustomerView(customer: customer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        sleep(10)
        
        let time = startBankWork()
        print(time.duringTime)
    }
    
    func openBank() {
        bank.createQueue()
        
        let customerCount: Int = Int.random(in: 10...30)
        
        for turn in 1...customerCount {
            guard let business = BankBusiness.allCases.randomElement() else { continue }
            let newCustomer: Customer = Customer(ticketNumber: turn, business: business)
            bank.addCustomer(customer: newCustomer)
            bankView.addNewCustomerView(customer: newCustomer)
        }
    }
    
    func startBankWork() -> ReportData {
        return measureTime {
            bank.startWork()
        }
    }
    
    func closeBank() {
        bank.resetCustomerQueue()
    }
    
    func measureTime(_ closure: () -> Void) -> ReportData {
        let startDate = Date()
        closure()
        return (0, Date().timeIntervalSince(startDate))
    }
}
