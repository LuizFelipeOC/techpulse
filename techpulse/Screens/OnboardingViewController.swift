//
//  OnboardingViewController.swift
//  techpulse
//
//  Created by Luiz Felipe on 27/06/26.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    let titleLabel          = TPTitle(textAlignment: .left, fontSize: 24)
    let subtitleLabel       = TPSecondaryLabel(textAlignment: .left, fontSize: 16)
    let onboardingImage     = UIImageView()
    let onboardingButton    = TPButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureOnboarding()
    }
    
    private func configureOnboarding(){
        view.backgroundColor = .white

        configureHeader()
        configureOnboardingImage()
        configureButton()
    }
    
    private func configureHeader() {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])

        stack.axis = .vertical
        stack.spacing = 2
        
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "Bem-vindo ao TechPulse"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)

        subtitleLabel.text = "Fique por dentro das novidades do mundo da tecnologia"
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .left
        subtitleLabel.textColor = .systemGray

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func configureOnboardingImage() {
        onboardingImage.image                                     = UIImage(named: "OnboardingImage")
        onboardingImage.contentMode                               = .scaleAspectFit
        
        onboardingImage.translatesAutoresizingMaskIntoConstraints = false
    
        view.addSubview(onboardingImage)
        
        NSLayoutConstraint.activate([
            onboardingImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            onboardingImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            onboardingImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            onboardingImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85)
        ])
    }
    
    private func configureButton() {
        onboardingButton.setBackgroundColor(backgroundColor: .systemMint, title: "Continue")
        
        onboardingButton.translatesAutoresizingMaskIntoConstraints = false
        
        onboardingButton.addTarget(self, action: #selector(onboardingButtonTapped), for: .touchUpInside)
                
        view.addSubview(onboardingButton)
        
        NSLayoutConstraint.activate([
            onboardingButton.bottomAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                constant: -24
            ),
            onboardingButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            onboardingButton.widthAnchor.constraint(
                equalTo: self.view.widthAnchor,
                multiplier: 0.9
            ),
            onboardingButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    
    @objc func onboardingButtonTapped() {
        let mainTabBar = MainTabViewController()
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
        
        let window = windowScene.windows.first {
            window.rootViewController = mainTabBar
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
        }
    }
}
