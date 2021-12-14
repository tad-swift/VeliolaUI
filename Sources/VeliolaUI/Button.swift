//
//  Button.swift
//  Veliola
//
//  Created by Tadreik Campbell on 6/5/21.
//  Copyright © 2021 Tadreik Campbell. All rights reserved.
//

import UIKit

public class Button: UIButton {
    
    public enum Style: CaseIterable {
        case standard, round, exit, back, none
    }
    
    private var style: Style = .none
    private var title: String!
    
    public init(style: Style, action: @escaping () -> Void = {}, label: String = "") {
        super.init(frame: .zero)
        self.style = style
        self.title = label
        addAction(UIAction { _ in
            action()
        }, for: .touchUpInside)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if style == .standard {
            self.roundCorners(10)
        } else if style == .none {
            return
        } else {
            self.roundCorners(17)
        }
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Color.accentColor
        tintColor = .white
        setTitleColor(.white, for: .normal)
        setTitleColor(.darkGray, for: .highlighted)
        
        switch style {
        case .standard:
            contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            setTitle(title, for: .normal)
            titleLabel?.font = Font.subtitle
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: 44)
            ])
        case .round:
            NSLayoutConstraint.activate([
                self.widthAnchor.constraint(equalToConstant: 34),
                self.heightAnchor.constraint(equalToConstant: 34)
            ])
        case .exit:
            let config = UIImage.SymbolConfiguration(weight: .semibold)
            let image = UIImage(systemName: "xmark", withConfiguration: config)
            setImage(image, for: .normal)
            NSLayoutConstraint.activate([
                self.widthAnchor.constraint(equalToConstant: 34),
                self.heightAnchor.constraint(equalToConstant: 34)
            ])
        case .back:
            let config = UIImage.SymbolConfiguration(weight: .semibold)
            let image = UIImage(systemName: "chevron.left", withConfiguration: config)
            setImage(image, for: .normal)
            NSLayoutConstraint.activate([
                self.widthAnchor.constraint(equalToConstant: 34),
                self.heightAnchor.constraint(equalToConstant: 34)
            ])
        case .none:
            backgroundColor = .clear
            setTitle(title, for: .normal)
            setTitleColor(Color.accentColor, for: .normal)
            setTitleColor(.systemGray6, for: .highlighted)
            titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        }
    }
    
    func addAction(_ action: @escaping () -> Void) {
        addAction(UIAction { _ in action()}, for: .touchUpInside)
    }
}
