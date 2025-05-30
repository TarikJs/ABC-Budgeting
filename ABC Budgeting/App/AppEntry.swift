import SwiftUI
import UIKit

@main
struct ABCBudgetingApp: App {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
    var body: some Scene {
        WindowGroup {
            LaunchCoordinator()
        }
    }
}

struct LaunchCoordinator: View {
    @AppStorage("isOnboardingComplete") private var isOnboardingComplete: Bool = false
    @State private var showSplash = true
    @State private var showOnboarding = false

    var body: some View {
        Group {
            if showSplash {
                SplashScreenView(onComplete: {
                    if isOnboardingComplete {
                        showSplash = false
                    } else {
                        showSplash = false
                        showOnboarding = true
                    }
                })
            } else if showOnboarding {
                OnboardingView(onComplete: {
                    isOnboardingComplete = true
                    showOnboarding = false
                })
            } else {
                MainView()
            }
        }
        .onAppear {
            // Only show splash on cold launch
            if !isOnboardingComplete {
                showSplash = true
            } else {
                showSplash = true
            }
        }
    }
}

// MARK: - AppCoordinator (Commented out for now, can be restored if needed)
/*
final class AppCoordinator: ObservableObject {
    @Published private var isOnboardingComplete: Bool = UserDefaults.standard.bool(forKey: "isOnboardingComplete")
    @Published private var isSplashComplete: Bool = false

    func start() -> some View {
        Group {
            if !isSplashComplete {
                SplashScreenCoordinator(onComplete: {
                    self.isSplashComplete = true
                })
            } else if !isOnboardingComplete {
                OnboardingCoordinator(onComplete: {
                    self.isOnboardingComplete = true
                    UserDefaults.standard.set(true, forKey: "isOnboardingComplete")
                })
            } else {
                MainTabCoordinator()
            }
        }
    }
}

// MARK: - SplashScreenCoordinator (Stub)
struct SplashScreenCoordinator: View {
    let onComplete: () -> Void
    var body: some View {
        SplashScreenView(onComplete: onComplete)
    }
}

// MARK: - OnboardingCoordinator (Stub)
struct OnboardingCoordinator: View {
    let onComplete: () -> Void
    var body: some View {
        OnboardingView(onComplete: onComplete)
    }
}

// MARK: - MainTabCoordinator (Now accessible to MainView)
struct MainTabCoordinator: View {
    var body: some View {
        TabView {
            OverviewView()
                .tabItem {
                    Label("Overview", systemImage: "chart.pie")
                }
            TransactionsView()
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet.rectangle")
                }
            BudgetView()
                .tabItem {
                    Label("Budget", systemImage: "creditcard")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}
*/
