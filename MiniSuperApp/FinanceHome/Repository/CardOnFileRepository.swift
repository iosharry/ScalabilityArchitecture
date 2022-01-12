//
//  CardOnFileRepository.swift
//  MiniSuperApp
//
//  Created by ron.ios on 2022/01/12.
//

import Foundation

protocol CardOnFileRepository {
  var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }
}

final class CardOnFileRepositoryImp: CardOnFileRepository {
  var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { paymentMethodsSubject }
  
  private let paymentMethodsSubject = CurrentValuePublisher<[PaymentMethod]>([
    PaymentMethod(id: "0", name: "우리은행", digits: "0123", color: "#f19a38ff", isPrimary: false),
    PaymentMethod(id: "1", name: "신한카드", digits: "4567", color: "#3478f6ff", isPrimary: false),
    PaymentMethod(id: "2", name: "현대카드", digits: "8901", color: "#78c5f5ff", isPrimary: false),
    PaymentMethod(id: "3", name: "국민은행", digits: "1234", color: "#65c466ff", isPrimary: false),
    PaymentMethod(id: "4", name: "카카오뱅크", digits: "5678", color: "#ffcc00ff", isPrimary: false)
  ])
}
