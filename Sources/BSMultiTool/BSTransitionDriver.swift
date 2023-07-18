//
//  BSTransitionDriver.swift
//  
//
//  Created by Александр Александрович on 27.05.2023.
//

import UIKit

final class BSTransitionDriver: UIPercentDrivenInteractiveTransition, UIGestureRecognizerDelegate {

    override var wantsInteractiveStart: Bool {
        get {
            panRecognizer.state == .began
        }
        set {
            super.wantsInteractiveStart = newValue
        }
    }

    private lazy var panRecognizer: UIPanGestureRecognizer = {
        let panRecognizer = UIPanGestureRecognizer(
            target: self,
            action: #selector(handleDismiss)
        )
        panRecognizer.delegate = self
        return panRecognizer
    }()

    private weak var presentedController: UIViewController?

    init(controller: UIViewController, minTranslation: CGFloat) {
        self.minTranslation = minTranslation
        super.init()
        
        controller.view.addGestureRecognizer(panRecognizer)
        presentedController = controller
    }

    private var maxTranslation: CGFloat? {
        let height = presentedController?.view.frame.height ?? 0
        return height > 0 ? height : nil
    }
    
    private let minTranslation: CGFloat
    
    private var useMinTranslation: Bool {
        return minTranslation != 0
    }

    @objc
        private func handleDismiss(_ sender: UIPanGestureRecognizer) {
            guard let maxTranslation = maxTranslation else { return }

            switch sender.state {
            case .began:
                let isRunning = percentComplete != 0
                if !isRunning {
                    presentedController?.dismiss(animated: true)
                }

                pause()

            case .changed:
                let increment = sender.incrementToBottom(maxTranslation: maxTranslation)
                var newPercentComplete = percentComplete + increment
                
                if useMinTranslation {
                    let minPercentComplete = minTranslation / maxTranslation
                    newPercentComplete = max(min(newPercentComplete, 1.0), minPercentComplete)
                } else {
                    newPercentComplete = max(min(newPercentComplete, 1.0), 0.0) // Ограничиваем в диапазоне 0.0-1.0
                }
                
                update(newPercentComplete)

            case .ended, .cancelled:
                if useMinTranslation, sender.isProjectedToDownHalf(
                    maxTranslation: maxTranslation,
                    percentComplete: percentComplete
                ) {
                    finish()
                } else {
                    cancel()
                }

            case .failed:
                cancel()

            default:
                break
            }
        }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let velocity = panRecognizer.velocity(in: nil)
        if velocity.y > 0, abs(velocity.y) > abs(velocity.x) {
            return true
        } else {
            return false
        }
    }
}

