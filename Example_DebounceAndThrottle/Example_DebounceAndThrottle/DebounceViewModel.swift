//
//  DebounceViewModel.swift
//  Example_DebounceAndThrottle
//
//  Created by 서명렬 on 2021/07/03.
//

import Foundation
import Combine

final class DebounceViewModel {
  
  var text = CurrentValueSubject<String?, Never>(nil)
  var result = PassthroughSubject<String, Never>()
  
  var cancellables: Set<AnyCancellable> = []
  
  init() {
    bind()
  }
}

private extension DebounceViewModel {
  
  func bind() {
    text
      .debounce(for: 0.5, scheduler: RunLoop.main)
      .compactMap { $0 }
      .sink { self.result.send($0) }
      .store(in: &cancellables)
  }
}
