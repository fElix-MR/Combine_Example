//
//  ViewController.swift
//  Example_DebounceAndThrottle
//
//  Created by 서명렬 on 2021/07/03.
//

import UIKit

final class MainViewController: UIViewController {

  let debounceButton = UIButton(frame: .zero)
  let throttleButton = UIButton(frame: .zero)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraints()
  }
}

private extension MainViewController {
  
  func setupView() {
    title = "Main"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    debounceButton.setTitle("DEBOUNCE", for: .normal)
    debounceButton.setTitleColor(.black, for: .normal)
    debounceButton.addTarget(self, action: #selector(debounceButtonTapped(_:)), for: .touchUpInside)
    
    throttleButton.setTitle("THROTTLE", for: .normal)
    throttleButton.setTitleColor(.black, for: .normal)
    throttleButton.addTarget(self, action: #selector(throttleButtonTapped(_:)), for: .touchUpInside)
  }
  
  func setupConstraints() {
    [debounceButton, throttleButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      debounceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      debounceButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
      
      throttleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      throttleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100)
    ])
  }
  
  @objc func debounceButtonTapped(_ sender: UIButton) {
    navigationController?.pushViewController(DebounceViewController(), animated: true)
  }
  
  @objc func throttleButtonTapped(_ sender: UIButton) {
    navigationController?.pushViewController(ThrottleViewController(), animated: true)
  }
}

