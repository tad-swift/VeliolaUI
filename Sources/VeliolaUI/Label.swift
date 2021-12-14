//
//  Label.swift
//  Veliola
//
//  Created by Tadreik Campbell on 6/5/21.
//  Copyright © 2021 Tadreik Campbell. All rights reserved.
//

import UIKit

public class Label: UILabel {
    
    public init(style: UIFont, string: String = "") {
        super.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        font = style
        textColor = Color.dark
        text = string
        numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
