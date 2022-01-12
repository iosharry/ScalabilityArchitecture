//
//  SuperPayDashboardBuilder.swift
//  MiniSuperApp
//
//  Created by ron.ios on 2022/01/09.
//

import ModernRIBs
import Foundation

protocol SuperPayDashboardDependency: Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
  var balance: ReadOnlyCurrentValuePublisher<Double> { get }
}

// 리블렛 본인과 자식 리블렛이 필요한 객체들을 담을 바구니
final class SuperPayDashboardComponent: Component<SuperPayDashboardDependency>, SuperPayDashboardInteractorDependency {
  // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
  var balance: ReadOnlyCurrentValuePublisher<Double> { dependency.balance }
  var balanceFormmater: NumberFormatter { Formmater.balanceFormatter }
}

// MARK: - Builder

protocol SuperPayDashboardBuildable: Buildable {
  func build(withListener listener: SuperPayDashboardListener) -> SuperPayDashboardRouting
}

final class SuperPayDashboardBuilder: Builder<SuperPayDashboardDependency>, SuperPayDashboardBuildable {

  override init(dependency: SuperPayDashboardDependency) {
      super.init(dependency: dependency)
  }

  func build(withListener listener: SuperPayDashboardListener) -> SuperPayDashboardRouting {
      let component = SuperPayDashboardComponent(dependency: dependency)
      let viewController = SuperPayDashboardViewController()
      let interactor = SuperPayDashboardInteractor(
        presenter: viewController,
        dependency: component
      )
      interactor.listener = listener
      return SuperPayDashboardRouter(interactor: interactor, viewController: viewController)
  }
}
