//
//  BSTransitioningDelegate.swift
//  
//
//  Created by Александр Александрович on 27.05.2023.
//

import UIKit

final public class BSTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    private let minTranslation: CGFloat
    
    public init(minTranslation: CGFloat = 0) {
        self.minTranslation = minTranslation
    }

    private var driver: BSTransitionDriver?

    public func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        driver = BSTransitionDriver(controller: presented)

        return BSPresentationController(
            presentedViewController: presented,
            presenting: presenting ?? source
        )
    }

    public func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        CoverVerticalPresentAnimatedTransitioning()
    }

    public func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        CoverVerticalDismissAnimatedTransitioning()
    }

    public func interactionControllerForDismissal(
        using animator: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        driver
    }
}

