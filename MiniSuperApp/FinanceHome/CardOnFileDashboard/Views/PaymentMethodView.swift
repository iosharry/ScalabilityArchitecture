//
//  PaymentMethodView.swift
//  MiniSuperApp
//
//  Created by ron.ios on 2022/01/12.
//

import UIKit

final class PaymentMethodView: UIView {
  private let nameLabel: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.font = .systemFont(ofSize: 18, weight: .semibold)
    lb.textColor = .white
    return lb
  }()
  
  private let subTitleLabel: UILabel = {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.font = .systemFont(ofSize: 15, weight: .regular)
    lb.textColor = .white
    return lb
  }()
  
  init(viewModel: PaymentMethodViewModel){
    super.init(frame: .zero)
    setupViews()
    nameLabel.text = viewModel.name
    subTitleLabel.text = viewModel.digits
    backgroundColor = viewModel.color
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
  }
  
  private func setupViews() {
    addSubview(nameLabel)
    addSubview(subTitleLabel)
    NSLayoutConstraint.activate([
      nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
      nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      
      subTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
      subTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }
}
