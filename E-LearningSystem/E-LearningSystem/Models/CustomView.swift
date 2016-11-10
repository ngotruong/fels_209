//
//  CustomView.swift
//  E-LearningSystem
//
//  Created by Ngo Sy Truong on 11/14/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

extension UIView {
    func round(radius: CGFloat, borderWith: CGFloat, borderColor: CGColor?) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWith
        self.layer.borderColor = borderColor
    }
}
