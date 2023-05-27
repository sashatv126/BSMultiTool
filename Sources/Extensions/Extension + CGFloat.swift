//
//  File 2.swift
//  
//
//  Created by Александр Александрович on 27.05.2023.
//

import UIKit

extension CGFloat {
    func projectedOffset(decelerationRate: UIScrollView.DecelerationRate) -> CGFloat {
        let multiplier = 1 / (1 - decelerationRate.rawValue) / 1_000
        return self * multiplier
    }
}

