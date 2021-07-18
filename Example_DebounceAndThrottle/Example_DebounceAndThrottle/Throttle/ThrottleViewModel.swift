//
//  ThrottleViewModel.swift
//  Example_DebounceAndThrottle
//
//  Created by 서명렬 on 2021/07/04.
//

import Foundation
import Combine

final class ThrottleViewModel {

  private(set) var touchEvent = PassthroughSubject<Int, Never>()
  @Published private(set) var count = 0
  
  private var cancellables: Set<AnyCancellable> = []
  
  init() {
    bind()
  }
}

extension ThrottleViewModel {
  
  func bind() {
    touchEvent
      .throttle(for: 1, scheduler: RunLoop.main, latest: true)
      .sink { self.count += $0 }
      .store(in: &cancellables)
  }
}
