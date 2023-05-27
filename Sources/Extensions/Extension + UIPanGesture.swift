//
//  File.swift
//  
//
//  Created by Александр Александрович on 27.05.2023.
//

import UIKit

extension UIPanGestureRecognizer {
    public func incrementToBottom(maxTranslation: CGFloat) -> CGFloat {
        let translation = self.translation(in: view).y
        setTranslation(.zero, in: nil)

        let percentIncrement = translation / maxTranslation
        return percentIncrement
    }

    public func isProjectedToDownHalf(maxTranslation: CGFloat, percentComplete: CGFloat) -> Bool {
        let velocityOffset = velocity(in: view).projectedOffset(decelerationRate: .normal)
        let verticalTranslation = maxTranslation * percentComplete
        let translation = CGPoint(x: 0, y: verticalTranslation) + velocityOffset

        let isPresentationCompleted = translation.y > maxTranslation / 2
        return isPresentationCompleted
    }
}
