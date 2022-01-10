import ModernRIBs

public protocol AppHomeDependency: Dependency {
}

final class AppHomeComponent: Component<AppHomeDependency>, TransportHomeDependency {
}

// MARK: - Builder
// Builder: 리블렛 객체를 생성하는 역할 (ex. AppHome 리블렛은 AppHome 빌더가 만든다.)

public protocol AppHomeBuildable: Buildable {
  func build(withListener listener: AppHomeListener) -> ViewableRouting
}

public final class AppHomeBuilder: Builder<AppHomeDependency>, AppHomeBuildable {
  
  public override init(dependency: AppHomeDependency) {
    super.init(dependency: dependency)
  }
  
  // 리블렛에 필요한 객체들을 생성하는 부분
  public func build(withListener listener: AppHomeListener) -> ViewableRouting {
    // AppHome 리블렛에 로직이 추가될 때 로직을 수행하는 필요한 객체들을 담고 있을 바구니.
    let component = AppHomeComponent(dependency: dependency)
    
    let viewController = AppHomeViewController()
    
    // 비즈니스로직이 들어가는 리블렛의 두뇌.
    let interactor = AppHomeInteractor(presenter: viewController)
    interactor.listener = listener
    
    let transportHomeBuilder = TransportHomeBuilder(dependency: component)
    
    // 리블렛간의 이동을 담당.
    return AppHomeRouter(
      interactor: interactor,
      viewController: viewController,
      transportHomeBuildable: transportHomeBuilder
    )
  }
}
