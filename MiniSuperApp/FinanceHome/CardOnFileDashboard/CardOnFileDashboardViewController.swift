//
//  CardOnFileDashboardViewController.swift
//  MiniSuperApp
//
//  Created by ron.ios on 2022/01/12.
//

import ModernRIBs
import UIKit

protocol CardOnFileDashboardPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class CardOnFileDashboardViewController: UIViewController, CardOnFileDashboardPresentable, CardOnFileDashboardViewControllable {

  weak var listener: CardOnFileDashboardPresentableListener?
  
  private let headerStackView: UIStackView = {
    let sv = UIStackView()
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.alignment = .fill
    sv.distribution = .equalSpacing
    sv.axis = .horizontal
    return sv
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 22, weight: .semibold)
    label.text = "카드 및 계좌"
    return label
  }()
  
  private let seeAllButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("전체보기", for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    button.addTarget(self, action: #selector(seeAllButtonDidTap), for: .touchUpInside)
    return button
  }()
  
  private let cardOnFileStackView: UIStackView = {
    let sv = UIStackView()
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.alignment = .fill
    sv.distribution = .equalSpacing
    sv.axis = .vertical
    sv.spacing = 12
    return sv
  }()
  
  private let addMethodButton: AddPaymentMethodButton = {
    let button = AddPaymentMethodButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.roundCorners()
    button.backgroundColor = .gray
    button.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
    return button
  }()
  
  init() {
    super.init(nibName: nil, bundle: nil)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
  }
  
  private func setupViews() {
    view.addSubview(headerStackView)
    view.addSubview(cardOnFileStackView)
    
    headerStackView.addArrangedSubview(titleLabel)
    headerStackView.addArrangedSubview(seeAllButton)

    
    NSLayoutConstraint.activate([
      headerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
      headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      
      cardOnFileStackView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 10),
      cardOnFileStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      cardOnFileStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      cardOnFileStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      addMethodButton.heightAnchor.constraint(equalToConstant: 60)
    ])
  }
  
  func update(with viewModels: [PaymentMethodViewModel]) {
    cardOnFileStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    let views = viewModels.map(PaymentMethodView.init)
    views.forEach {
      $0.roundCorners()
      cardOnFileStackView.addArrangedSubview($0)
    }
    cardOnFileStackView.addArrangedSubview(addMethodButton)
    let heightContraints = views.map { $0.heightAnchor.constraint(equalToConstant: 60) }
    NSLayoutConstraint.activate(heightContraints)
  }
  
  @objc private func seeAllButtonDidTap() {
    
  }
  
  @objc private func addButtonDidTap() {
    
  }
}
