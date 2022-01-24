//
//  TopupBuilder.swift
//  MiniSuperApp
//
//  Created by ron.ios on 2022/01/24.
//

import ModernRIBs

protocol TopupDependency: Dependency {
  // TODO: Make sure to convert the variable into lower-camelcase.
  var topupBaseViewController: ViewControllable { get }
}

final class TopupComponent: Component<TopupDependency> {

  // TODO: Make sure to convert the variable into lower-camelcase.
  fileprivate var topupBaseViewController: ViewControllable {
      return dependency.topupBaseViewController
  }

  // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol TopupBuildable: Buildable {
  func build(withListener listener: TopupListener) -> TopupRouting
}

final class TopupBuilder: Builder<TopupDependency>, TopupBuildable {

  override init(dependency: TopupDependency) {
      super.init(dependency: dependency)
  }

  func build(withListener listener: TopupListener) -> TopupRouting {
      let component = TopupComponent(dependency: dependency)
      let interactor = TopupInteractor()
      interactor.listener = listener
    return TopupRouter(interactor: interactor, viewController: component.topupBaseViewController)
  }
}
