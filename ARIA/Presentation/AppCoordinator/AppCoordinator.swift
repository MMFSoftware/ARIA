import SwiftUI

struct AppCoordinator: View {
    @StateObject private var coordinator = AppCoordinatorViewModel()
    
    var body: some View {
        Group {
            switch coordinator.currentScreen {
            case .splash:
                SplashView(viewModel: SplashViewModel(coordinator: coordinator))
            case .content:
                HomeView(viewModel: HomeViewModel())
            }
        }
    }
}

class AppCoordinatorViewModel: ObservableObject {
    enum Screen {
        case splash
        case content
    }
    
    @Published var currentScreen: Screen = .splash
    
    func navigateToScreen(_ screen: Screen) {
        withAnimation {
            self.currentScreen = screen
        }
    }
}
