import ModernRIBs

protocol AppHomeRouting: ViewableRouting {
  func attachTransportHome()
  func detachTransportHome()
}

protocol AppHomePresentable: Presentable {
  var listener: AppHomePresentableListener? { get set }
  
  func updateWidget(_ viewModels: [HomeWidgetViewModel])
}

// AppHome 리블렛이 부모리블렛에게 이벤트를 전달할 때 사용. (익숙한 delegate 패턴)
public protocol AppHomeListener: AnyObject {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class AppHomeInteractor: PresentableInteractor<AppHomePresentable>, AppHomeInteractable, AppHomePresentableListener {
  
  weak var router: AppHomeRouting?
  weak var listener: AppHomeListener?
  
  override init(presenter: AppHomePresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    
    let viewModels = [
      HomeWidgetModel(
        imageName: "car",
        title: "슈퍼택시",
        tapHandler: { [weak self] in
          self?.router?.attachTransportHome()
        }
      ),
      HomeWidgetModel(
        imageName: "cart",
        title: "슈퍼마트",
        tapHandler: { }
      )
    ]
    
    presenter.updateWidget(viewModels.map(HomeWidgetViewModel.init))
  }
  
  func transportHomeDidTapClose() {
    router?.detachTransportHome()
  }
  
}
