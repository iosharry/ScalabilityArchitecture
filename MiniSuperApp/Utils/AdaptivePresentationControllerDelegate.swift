//
//  AdaptivePresentationControllerDelegate.swift
//  MiniSuperApp
//
//  Created by ron.ios on 2022/01/13.
//

import UIKit

protocol AdaptivePresentationControllerDelegate: AnyObject {
  func presentationControllerDidDismiss()
}

final class AdaptivePresentationControllerDelegateProxy: NSObject, UIAdaptivePresentationControllerDelegate {
  weak var delegate: AdaptivePresentationControllerDelegate?
  
  func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
    delegate?.presentationControllerDidDismiss()
  }
}
