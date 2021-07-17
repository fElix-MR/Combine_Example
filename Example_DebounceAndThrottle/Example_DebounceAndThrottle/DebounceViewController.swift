//
//  DebounceViewController.swift
//  Example_DebounceAndThrottle
//
//  Created by 서명렬 on 2021/07/03.
//

import UIKit
import Combine

final class DebounceViewController: UIViewController {

  let viewModel = DebounceViewModel()
  var cancellables: Set<AnyCancellable> = []
  
  let textField = UITextField(frame: .zero)
  let resultLabel = UILabel(frame: .zero)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraints()
    bind()
  }
}

extension DebounceViewController {
  
  func bind() {
    viewModel.result
      .receive(on: RunLoop.main)
      .compactMap { $0 }
      .assign(to: \.text, on: resultLabel)
      .store(in: &cancellables)
  }
  
  func setupView() {
    title = "Debounce"
    view.backgroundColor = .white
    navigationController?.navigationBar.prefersLargeTitles = true
    
    textField.layer.borderWidth = 1
    textField.layer.cornerRadius = 10
    textField.layer.borderColor = UIColor.black.cgColor
    textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    
    resultLabel.layer.borderWidth = 1
    resultLabel.layer.cornerRadius = 10
    resultLabel.layer.borderColor = UIColor.black.cgColor
    resultLabel.numberOfLines = 0
  }
  
  func setupConstraints() {
    [textField, resultLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
      textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
      textField.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
      
      resultLabel.centerXAnchor.constraint(equalTo: textField.centerXAnchor),
      resultLabel.widthAnchor.constraint(equalTo: textField.widthAnchor),
      resultLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 50),
      resultLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
    ])
  }
  
  @objc func textFieldEditingChanged(_ sender: UITextField) {
    viewModel.text.send(sender.text)
  }
}
