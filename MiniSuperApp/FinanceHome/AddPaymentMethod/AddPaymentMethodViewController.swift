//
//  AddPaymentMethodViewController.swift
//  MiniSuperApp
//
//  Created by ron.ios on 2022/01/13.
//

import ModernRIBs
import UIKit

protocol AddPaymentMethodPresentableListener: AnyObject {
  // TODO: Declare properties and methods that the view controller can invoke to perform
  // business logic, such as signIn(). This protocol is implemented by the corresponding
  // interactor class.
  func didTapClose()
  func didTapConfirm(with number: String, cvc: String, expiry: String)
}

final class AddPaymentMethodViewController: UIViewController, AddPaymentMethodPresentable, AddPaymentMethodViewControllable {

  weak var listener: AddPaymentMethodPresentableListener?
  
  private let cardNumberTextField: UITextField = {
    let tf = makeTextField()
    tf.placeholder = "카드 번호"
    return tf
  }()
  
  private let securityTextField: UITextField = {
    let tf = makeTextField()
    tf.placeholder = "CVC"
    return tf
  }()
  
  private let expirationTextField: UITextField = {
    let tf = makeTextField()
    tf.placeholder = "유효기간"
    return tf
  }()
  
  private let addCardButton: UIButton = {
    let btn = UIButton()
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.roundCorners()
    btn.backgroundColor = .primaryRed
    btn.setTitle("추가하기", for: .normal)
    btn.addTarget(self, action: #selector(didTapAddCard), for: .touchUpInside)
    return btn
  }()
  
  private let stackView: UIStackView = {
    let sv = UIStackView()
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.axis = .horizontal
    sv.alignment = .center
    sv.distribution = .fillEqually
    sv.spacing = 14
    return sv
  }()
  
  private static func makeTextField() -> UITextField {
    let tf = UITextField()
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.backgroundColor = .white
    tf.borderStyle = .roundedRect
    tf.keyboardType = .numberPad
    return tf
  }
  
  init() {
    super.init(nibName: nil, bundle: nil)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
  }
  
  private func setupViews() {
    title = "카드 추가"
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: UIImage(
        systemName: "xmark",
        withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
      ),
      style: .plain,
      target: self,
      action: #selector(didTapClose)
    )
    view.backgroundColor = .backgroundColor
    view.addSubview(cardNumberTextField)
    view.addSubview(stackView)
    view.addSubview(addCardButton)
    
    stackView.addArrangedSubview(securityTextField)
    stackView.addArrangedSubview(expirationTextField)
    
    NSLayoutConstraint.activate([
      cardNumberTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
      cardNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
      cardNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
      cardNumberTextField.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -20),
      
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
      stackView.bottomAnchor.constraint(equalTo: addCardButton.topAnchor, constant: -20),
      
      addCardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
      addCardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
      
      cardNumberTextField.heightAnchor.constraint(equalToConstant: 60),
      securityTextField.heightAnchor.constraint(equalToConstant: 60),
      expirationTextField.heightAnchor.constraint(equalToConstant: 60),
      addCardButton.heightAnchor.constraint(equalToConstant: 60)
    ])
  }
  
  @objc private func didTapAddCard() {
    if let number = cardNumberTextField.text,
       let cvc = securityTextField.text,
       let expiry = expirationTextField.text {
      listener?.didTapConfirm(with: number, cvc: cvc, expiry: expiry)
    }
  }
  
  @objc private func didTapClose() {
    listener?.didTapClose()
  }
}
