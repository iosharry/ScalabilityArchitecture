import ModernRIBs

protocol FinanceHomeDependency: Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
}

final class FinanceHomeComponent: Component<FinanceHomeDependency>, SuperPayDashboardDependency, CardOnFileDashboardDependency, AddPaymentMethodDependency, TopupDependency {
  var topupBaseViewController: ViewControllable
  
  // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
  private let balancePublisher: CurrentValuePublisher<Double>
  var balance: ReadOnlyCurrentValuePublisher<Double> { balancePublisher }
  var cardOnFileRepository: CardOnFileRepository
  init(dependency: FinanceHomeDependency,
       balance: CurrentValuePublisher<Double>,
       cardOnFileRepository: CardOnFileRepository,
       topupBaseViewController: ViewControllable) {
    self.balancePublisher = balance
    self.cardOnFileRepository = cardOnFileRepository
    self.topupBaseViewController = topupBaseViewController
    super.init(dependency: dependency)
  }
}

// MARK: - Builder

protocol FinanceHomeBuildable: Buildable {
  func build(withListener listener: FinanceHomeListener) -> FinanceHomeRouting
}

final class FinanceHomeBuilder: Builder<FinanceHomeDependency>, FinanceHomeBuildable {
  
  override init(dependency: FinanceHomeDependency) {
    super.init(dependency: dependency)
  }
  
  func build(withListener listener: FinanceHomeListener) -> FinanceHomeRouting {
    let balancePublisher = CurrentValuePublisher<Double>(10000)
    let vc = FinanceHomeViewController()
    let component = FinanceHomeComponent(
      dependency: dependency,
      balance: balancePublisher,
      cardOnFileRepository: CardOnFileRepositoryImp(),
      topupBaseViewController: vc
    )
    let viewController = FinanceHomeViewController()
    let interactor = FinanceHomeInteractor(presenter: viewController)
    interactor.listener = listener
    
    let superPayDashboardBuilder = SuperPayDashboardBuilder(dependency: component)
    let cardOnFileDashboardBuilder = CardOnFileDashboardBuilder(dependency: component)
    let addPaymentMethodBuilder = AddPaymentMethodBuilder(dependency: component)
    let toupBuilder = TopupBuilder(dependency: component)
    
    return FinanceHomeRouter(
      interactor: interactor,
      viewController: viewController,
      superPayDashboardBuildable: superPayDashboardBuilder,
      cardOnFileDashboardBuildable: cardOnFileDashboardBuilder,
      addPaymentMethodBuildable: addPaymentMethodBuilder,
      topupBuildable: toupBuilder
    )
  }
}
