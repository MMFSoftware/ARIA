import Foundation
import Combine

class SplashViewModel: ObservableObject {
    @Published var showTitle = false
    @Published var showLoading = false
    
    private let coordinator: AppCoordinatorViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(coordinator: AppCoordinatorViewModel) {
        self.coordinator = coordinator
        setupTimers()
    }
    
    private func setupTimers() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.showTitle = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                self?.showLoading = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
                    self?.navigateToContentView()
                }
            }
        }
    }
    
    func navigateToContentView() {
        coordinator.navigateToScreen(.content)
    }
}
