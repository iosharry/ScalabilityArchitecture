//
//  AddPaymentMethodButton.swift
//  MiniSuperApp
//
//  Created by ron.ios on 2022/01/12.
//

import UIKit

final class AddPaymentMethodButton : UIControl {
  private let plusIcon: UIImageView = {
    let iv = UIImageView(
      image: UIImage(
        systemName: "plus",
        withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
      )
    )
    iv.tintColor = .white
    iv.translatesAutoresizingMaskIntoConstraints = false
    return iv
  }()
  
  init(){
    super.init(frame: .zero)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
  }
  
  private func setupViews() {
    addSubview(plusIcon)
    NSLayoutConstraint.activate([
      plusIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      plusIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }
}
