//
//  ViewController.swift
//  amkorolevPW2
//
//  Created by Андрей Королев on 26.10.2021.
//

import UIKit

class ViewController: UIViewController {
    private let settingsView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.lightGray
        setupSettingsView()
        setupSettingsButton()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func setupSettingsButton() {
        let settingsButton = UIButton(type: .system)
        view.addSubview(settingsButton)
        print("btn created")
        //settingsButton.setTitle("settings", for: .normal)
        settingsButton.setImage(UIImage(named: "settings")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        settingsButton.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
        
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        settingsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        settingsButton.widthAnchor.constraint(equalTo: settingsButton.heightAnchor).isActive = true
    }
    
    @objc private func settingsButtonPressed() {
        UIView.animate(withDuration: 0.2, animations: {self.settingsView.alpha = 1 - self.settingsView.alpha})
    }
    
    private func setupSettingsView() {
        view.addSubview(settingsView)
        settingsView.backgroundColor = UIColor.darkGray
        settingsView.alpha = 0
        
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        settingsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        settingsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        settingsView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        settingsView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
}

