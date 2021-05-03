//
//  KeyboardObserver.swift
//  SwiftUIMemo
//
//  Created by APPLE on 2021/05/04.
//

import UIKit
import Combine

class KeyboardObserver: ObservableObject {
    struct Context {
        let animationDuration: TimeInterval
        let height: CGFloat
        
        static let hide = Self(animationDuration: 0.25, height: 0)
    }
    
    // 값이 업데이트 되면 연관된 뷰가 자동으로 업데이트 될 수 있도록 해주는 Published
    @Published var context = Context.hide
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
        
        willShow.merge(with: willHide)
            .compactMap(parse)
            .assign(to: \.context, on: self)
            .store(in: &cancellables)
    }
    
    func parse(notification: Notification) -> Context? {
        guard let userInfo = notification.userInfo else { return nil }
        let safeAreaInsets = UIApplication.shared.windows.first?.safeAreaInsets
        let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.25
        
        var height: CGFloat = 0
        
        if let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let frame = value.cgRectValue
            
            if frame.origin.y < UIScreen.main.bounds.height {
                height = frame.height - (safeAreaInsets?.bottom ?? 0)
            }
        }
        
        return Context(animationDuration: animationDuration, height: height)
    }
}
