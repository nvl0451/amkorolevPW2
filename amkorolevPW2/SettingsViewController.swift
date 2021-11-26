//
//  SettingsViewController.swift
//  amkorolevPW2
//
//  Created by Андрей Королев on 22.11.2021.
//

import UIKit

final class SettingsViewController:UIViewController {
    private let settingsView = UIView()
    private let locationTextView = UITextView()
    let locationToggle = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettingsView()
        setUpLocationToggle()
        setupCloseButton()
        
    }
    
    public var completionToggle: ((Bool?) -> Void)?
    
    init(toggleIsOn: Bool) {
        super.init(nibName: nil, bundle: nil)
        locationToggle.isOn = toggleIsOn
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSettingsView() {
        view.addSubview(settingsView)
        settingsView.backgroundColor = UIColor.darkGray
        settingsView.alpha = 1
        
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        settingsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        settingsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        settingsView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        settingsView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func setUpLocationToggle() {
        settingsView.addSubview(locationToggle)
        
        locationToggle.translatesAutoresizingMaskIntoConstraints = false
        locationToggle.topAnchor.constraint(equalTo: settingsView.topAnchor, constant: 80).isActive = true
        locationToggle.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -10).isActive = true
        //locationToggle.addTarget(self, action: #selector(locationToggleSwitched), for: .valueChanged)
        
        let locationLabel = UILabel()
        settingsView.addSubview(locationLabel)
        locationLabel.text = "Track location"
        locationLabel.textColor = UIColor.white
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: settingsView.topAnchor, constant: 85).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 10).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: locationToggle.leadingAnchor, constant: -10).isActive = true
    }
    
    
    private func setupCloseButton() {
        let button = UIButton(type: .close)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
        button.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
    }
    
    @objc private func closeScreen() {
        completionToggle?(locationToggle.isOn)
        dismiss(animated: true, completion: nil)
    }
}
