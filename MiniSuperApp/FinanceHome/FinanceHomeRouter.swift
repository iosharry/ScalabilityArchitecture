import ModernRIBs

protocol FinanceHomeInteractable: Interactable, SuperPayDashboardListener, CardOnFileDashboardListener {
  var router: FinanceHomeRouting? { get set }
  var listener: FinanceHomeListener? { get set }
}

protocol FinanceHomeViewControllable: ViewControllable {
  // TODO: Declare methods the router invokes to manipulate the view hierarchy.
  func addDashboard(_ view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {
  
  private let superPayDashboardBuildable: SuperPayDashboardBuildable
  private var superPayRouting: Routing?
  
  private let cardOnFileDashboardBuildable: CardOnFileDashboardBuildable
  private var cardOnFileRouting: Routing?
  
  init(interactor: FinanceHomeInteractable,
       viewController: FinanceHomeViewControllable,
       superPayDashboardBuildable: SuperPayDashboardBuildable,
       cardOnFileDashboardBuildable: CardOnFileDashboardBuildable) {
    self.superPayDashboardBuildable = superPayDashboardBuildable
    self.cardOnFileDashboardBuildable = cardOnFileDashboardBuildable
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  func attachSuperPayDashboard() {
    guard superPayRouting == nil else { return }
    let router = superPayDashboardBuildable.build(withListener: interactor)
    let dashboard = router.viewControllable
    viewController.addDashboard(dashboard)
    self.superPayRouting = router
    attachChild(router)
  }
  
  func attachCardOnFileDashboard() {
    guard cardOnFileRouting == nil else { return }
    let router = cardOnFileDashboardBuildable.build(withListener: interactor)
    let dashboard = router.viewControllable
    viewController.addDashboard(dashboard)
    self.cardOnFileRouting = router
    attachChild(router)
  }
}
