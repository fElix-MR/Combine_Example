//
//  ThrottleViewController.swift
//  Example_DebounceAndThrottle
//
//  Created by 서명렬 on 2021/07/03.
//

import UIKit
import Combine

final class ThrottleViewController: UIViewController {
  
  let viewModel = ThrottleViewModel()
  
  let plusButton = CustomButton(frame: .zero)
  let minusButton = CustomButton(frame: .zero)
  let resultLabel = UILabel(frame: .zero)
  
  private var cancellables: Set<AnyCancellable> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraints()
    bind()
  }
  
}

private extension ThrottleViewController {
  
  func bind() {
    viewModel.$count
      .sink { self.resultLabel.text = "\($0)"}
      .store(in: &cancellables)
  }
  
  func setupView() {
    title = "Throttle"
    view.backgroundColor = .white
    navigationController?.navigationBar.prefersLargeTitles = true
    
    plusButton.setTitle("+ Button", for: .normal)
    plusButton.addTarget(self, action: #selector(plusButtonTapped(_:)), for: .touchUpInside)
    
    minusButton.setTitle("- Button", for: .normal)
    minusButton.addTarget(self, action: #selector(minusButtonTapped(_:)), for: .touchUpInside)
  }
  
  func setupConstraints() {
    [plusButton, minusButton, resultLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      resultLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0),
      
      plusButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 50),
      plusButton.centerXAnchor.constraint(equalTo: resultLabel.centerXAnchor, constant: -55),
      plusButton.widthAnchor.constraint(equalToConstant: 100),
      
      minusButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 50),
      minusButton.centerXAnchor.constraint(equalTo: resultLabel.centerXAnchor, constant: 55),
      minusButton.widthAnchor.constraint(equalToConstant: 100),
    ])
  }
  
  @objc func plusButtonTapped(_ sender: UIButton) {
    viewModel.touchEvent.send(1)
  }
  
  @objc func minusButtonTapped(_ sender: UIButton) {
    viewModel.touchEvent.send(-1)
  }
}

final class CustomButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    setTitleColor(.black, for: .normal)
    setTitleColor(.red, for: .highlighted)
    layer.borderWidth = 1
    layer.borderColor = UIColor.black.cgColor
  }
}
