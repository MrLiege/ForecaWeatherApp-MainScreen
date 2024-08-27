//
//  OnboardingViewModel.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 23.08.2024.
//

import Foundation
import Combine

final class OnboardingViewModel: ObservableObject {
    // MARK: - Variables
    let input = Input()
    @Published var output = Output()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Services
    private let authService: Authenticatable
    
    init(authService: Authenticatable) {
        self.authService = authService
        bindButton()
    }
    
    func nextStep() {
        if let currentIndex = output.steps.firstIndex(of: output.currentStep),
           currentIndex < output.steps.count - 1 {
            output.currentStep = output.steps[currentIndex + 1]
        }
    }
}

private extension OnboardingViewModel {
    func bindButton() {
        input.onDone
            .sink { [weak self] in
                self?.authService.authCompleted.send(.onboardingDone)
                UserStorage.shared.isOnboardingDone = true
                UserStorage.shared.appState = .main
            }
            .store(in: &cancellables)
    }
}

extension OnboardingViewModel {
    struct Input {
        let onDone = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        let steps: [OnboardingStep] = OnboardingStep.allCases
        
        var currentStep: OnboardingStep = .welcome
        var isButtonVisible: Bool {
            currentStep == steps.last
        }
    }
}

enum OnboardingStep: String, Identifiable, CaseIterable {
    case welcome = "Добро пожаловать!"
    case forWhat = "Для чего это приложение?"
    case letsGo = "Начните пользоваться уже сейчас!"
    
    var id: String {
        rawValue
    }
    
    var subtitle: String {
        switch self {
        case .welcome:
            return "Очень рады видеть вас"
        case .forWhat:
            return "Очевидно, чтоб погоду смотреть..."
        case .letsGo:
            return "Давайте, уже пора!"
        }
    }
    
    var imageName: String {
        switch self {
        case .welcome:
            return "onboarding-1"
        case .forWhat:
            return "onboarding-2"
        case .letsGo:
            return "onboarding-3"
        }
    }
}
