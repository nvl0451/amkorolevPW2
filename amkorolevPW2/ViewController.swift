//
//  ViewController.swift
//  amkorolevPW2
//
//  Created by Андрей Королев on 26.10.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSettingsButton()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func setupSettingsButton() {
        let settingsButton = UIButton(type: .system)
        view.addSubview(settingsButton)
        print("btn")
        //settingsButton.setTitle("settings", for: .normal)
        settingsButton.setImage(UIImage(named: "settings")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        
        
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        settingsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        settingsButton.widthAnchor.constraint(equalTo: settingsButton.heightAnchor).isActive = true
    }
    
}

