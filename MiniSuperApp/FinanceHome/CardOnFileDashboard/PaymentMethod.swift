//
//  PaymentMethod.swift
//  MiniSuperApp
//
//  Created by ron.ios on 2022/01/12.
//

import Foundation

struct PaymentMethod: Decodable {
  let id:String
  let name:String
  let digits:String
  let color:String
  let isPrimary:Bool
}
