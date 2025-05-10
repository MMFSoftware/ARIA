import SwiftUI

struct SplashView: View {
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        ZStack {
            Color(.bg).ignoresSafeArea()

            VStack(spacing: 20) {
                LogoView()
                
                if viewModel.showTitle {
                    TitleView()
                }
                
                if viewModel.showLoading {
                    LoadingIndicator()
                }
            }
            .padding()
        }
    }
}

#Preview {
    SplashView(viewModel: SplashViewModel(coordinator: AppCoordinatorViewModel()))
}
