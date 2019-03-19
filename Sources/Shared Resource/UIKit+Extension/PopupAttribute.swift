//
//  PopupAttribute.swift
//  SharedResources
//
//  Created by Chhem Sronglong on 16/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation

import SwiftEntryKit

struct PopupAttribute {
    
    func getAttribue ()-> EKAttributes {
        var attributes = EKAttributes.centerFloat
        attributes.hapticFeedbackType = .success
        attributes.displayDuration = .infinity
        attributes.entryBackground = .gradient(gradient: .init(colors: [UIColor.green, UIColor.red], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.screenBackground = .color(color:  UIColor(white: 50.0/255.0, alpha: 0.3))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 8))
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.roundCorners = .all(radius: 8)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.7, spring: .init(damping: 0.7, initialVelocity: 0)),
                                             scale: .init(from: 0.7, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.exitAnimation = .init(translate: .init(duration: 0.2))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.35)))
        attributes.positionConstraints.size = .init(width: .offset(value: 20), height: .intrinsic)
        //  attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)
        attributes.statusBar = .dark
        return attributes
    }
    
}
