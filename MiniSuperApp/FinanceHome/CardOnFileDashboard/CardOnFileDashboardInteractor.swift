//
//  CardOnFileDashboardInteractor.swift
//  MiniSuperApp
//
//  Created by ron.ios on 2022/01/12.
//

import ModernRIBs
import Combine

protocol CardOnFileDashboardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol CardOnFileDashboardPresentable: Presentable {
  var listener: CardOnFileDashboardPresentableListener? { get set }
  // TODO: Declare methods the interactor can invoke the presenter to present data.
  func update(with viewModels:[PaymentMethodViewModel])
}

protocol CardOnFileDashboardListener: AnyObject {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

protocol CardOnFileDashboardInteractorDependency {
  var cardOnFileRepository: CardOnFileRepository { get }
}

final class CardOnFileDashboardInteractor: PresentableInteractor<CardOnFileDashboardPresentable>, CardOnFileDashboardInteractable, CardOnFileDashboardPresentableListener {

  weak var router: CardOnFileDashboardRouting?
  weak var listener: CardOnFileDashboardListener?

  private let dependency: CardOnFileDashboardInteractorDependency
  private var cancellables: Set<AnyCancellable>

  // TODO: Add additional dependencies to constructor. Do not perform any logic
  // in constructor.
  init(presenter: CardOnFileDashboardPresentable, dependency: CardOnFileDashboardInteractorDependency) {
    self.dependency = dependency
    self.cancellables = .init()
    super.init(presenter: presenter)
    presenter.listener = self
  }

  override func didBecomeActive() {
    super.didBecomeActive()
    // TODO: Implement business logic here.
    dependency.cardOnFileRepository.cardOnFile.sink { methods in
      // 메소드를 뷰모델로 변환해서 presenter에 넘긴다.
      let viewModels = methods.prefix(5).map(PaymentMethodViewModel.init)
      self.presenter.update(with: viewModels)
    }.store(in: &cancellables)
  }

  override func willResignActive() {
    super.willResignActive()
    // TODO: Pause any business logic.
    cancellables.forEach { $0.cancel() }
    cancellables.removeAll()
  }
}
