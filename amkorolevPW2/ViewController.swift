//
//  ViewController.swift
//  amkorolevPW2
//
//  Created by Андрей Королев on 26.10.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    private let settingsView = UIView()
    private let locationTextView = UITextView()
    private let locationManager = CLLocationManager()
    let locationToggle = UISwitch()
    let sliders = [UISlider(), UISlider(), UISlider()]
    let colors = ["Red", "Green", "Blue"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.lightGray
        setupLocationView()
        setupSettingsView()
        setUpLocationToggle()
        locationManager.requestWhenInUseAuthorization()
        setupSettingsButton()
        setupSliders()
    }
    
    private func setupSliders() {
        var top = 160
        for i in 0...(sliders.count - 1) {
            let view = UIView()
            settingsView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 10).isActive = true
            view.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -10).isActive = true
            view.topAnchor.constraint(equalTo: settingsView.topAnchor, constant: CGFloat(top)).isActive = true
            view.heightAnchor.constraint(equalToConstant: 30).isActive = true
            top += 40
            
            let label = UILabel()
            view.addSubview(label)
            label.text = colors[i]
            label.textColor = UIColor.white
            label.translatesAutoresizingMaskIntoConstraints = false
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            label.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
            let slider = sliders[i]
            slider.translatesAutoresizingMaskIntoConstraints = false
            slider.minimumValue = 0
            slider.maximumValue = 1
            slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
            view.addSubview(slider)
            slider.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
            slider.heightAnchor.constraint(equalToConstant: 20).isActive = true
            slider.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 10).isActive = true
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
    }
    
    @objc func sliderValueChanged() {
        let red: CGFloat = CGFloat(sliders[0].value)
        let green: CGFloat = CGFloat(sliders[1].value)
        let blue: CGFloat = CGFloat(sliders[2].value)
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
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
    
    private var buttonCount = 0
    @objc private func settingsButtonPressed() {
        switch buttonCount {
        case 0, 1:
            UIView.animate(withDuration: 0.2, animations: {self.settingsView.alpha = 1 - self.settingsView.alpha})
        case 2:
            navigationController?.pushViewController(SettingsViewController(toggleIsOn: locationToggle.isOn), animated: true)
        case 3:
            let settingsCall = SettingsViewController(toggleIsOn: locationToggle.isOn)
            settingsCall.completionToggle = { [weak self] toggleIsOn in
                if (self?.locationToggle.isOn != toggleIsOn) {
                    self?.locationToggle.isOn = toggleIsOn!
                    self?.locationToggleSwitched(self!.locationToggle)
                }
            }
            present(settingsCall, animated: true, completion: nil)
        default:
            buttonCount = -1
        }
        buttonCount += 1
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
    
    private func setupLocationView() {
        view.addSubview(locationTextView)
        
        locationTextView.backgroundColor = .white
        locationTextView.layer.cornerRadius = 20
        locationTextView.translatesAutoresizingMaskIntoConstraints = false
        locationTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90).isActive = true
        locationTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        locationTextView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        locationTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        locationTextView.isUserInteractionEnabled = false
    }
    
    private func setUpLocationToggle() {
        settingsView.addSubview(locationToggle)
        
        locationToggle.translatesAutoresizingMaskIntoConstraints = false
        locationToggle.topAnchor.constraint(equalTo: settingsView.topAnchor, constant: 80).isActive = true
        locationToggle.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor, constant: -10).isActive = true
        locationToggle.addTarget(self, action: #selector(locationToggleSwitched), for: .valueChanged)
        
        let locationLabel = UILabel()
        settingsView.addSubview(locationLabel)
        locationLabel.text = "Track location"
        locationLabel.textColor = UIColor.white
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: settingsView.topAnchor, constant: 85).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 10).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: locationToggle.leadingAnchor, constant: -10).isActive = true
    }
    
    @objc func locationToggleSwitched(_ sender:UISwitch) {
        if sender.isOn {
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            } else {
                sender.setOn(false, animated: true)
            }
        } else {
            locationTextView.text = ""
            locationManager.stopUpdatingLocation()
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coord: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        locationTextView.text = "Current coordinates = \(coord.latitude) \(coord.longitude)"
    }
}
