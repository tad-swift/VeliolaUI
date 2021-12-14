//
//  TableViewController.swift
//  Veliola
//
//  Created by Tadreik Campbell on 6/7/21.
//  Copyright © 2021 Tadreik Campbell. All rights reserved.
//

import UIKit

public class Group: UIView {
    
    public var headerView: UIView?
    public var footerView: UIView?
    
    let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .systemGray5
        v.layer.cornerRadius = 10
        v.layer.masksToBounds = true
        return v
    }()
    
    public var cells: [UIView] = []
    
    public init(cellList: [UIView], head: UIView?, foot: UIView?) {
        super.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        headerView = head
        footerView = foot
        cells = cellList
        createLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createLayout() {
        container.addSubviews(cells)
        addSubviews(headerView!, container, footerView!)
        NSLayoutConstraint.activate([
            headerView!.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            headerView!.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            headerView!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            container.topAnchor.constraint(equalTo: headerView!.bottomAnchor, constant: 8),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            cells[0].topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            cells[0].leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            cells[0].trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            
        ])
        for (index, cell) in cells.enumerated() {
            if index != 0 {
                NSLayoutConstraint.activate([
                    cell.topAnchor.constraint(equalTo: cells[index - 1].bottomAnchor, constant: 1),
                    cell.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
                    cell.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0)
                ])
            }
            if index + 1 == cells.count {
                cell.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
            }
        }
        NSLayoutConstraint.activate([
            footerView!.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 6),
            footerView!.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            footerView!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            footerView!.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

public class TableCell: UIControl {
    
    public override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = .systemGray5
            } else {
                backgroundColor = .white
            }
        }
    }
    
    public override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = .systemGray5
            } else {
                backgroundColor = .white
            }
        }
    }
    
    let label = Label(style: UIFont.systemFont(ofSize: 17, weight: .medium))
    let chevron: UIImageView = {
        let config = UIImage.SymbolConfiguration(weight: .semibold)
        let image = UIImage(systemName: "chevron.right", withConfiguration: config)
        let v = UIImageView(image: image)
        v.tintColor = Color.dark
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    var iconView: UIImageView?
    
    public init(text: String, icon: UIImage?, action: (Any, Selector)) {
        super.init(frame: CGRect.zero)
        label.text = text
        label.isUserInteractionEnabled = false
        chevron.isUserInteractionEnabled = false
        backgroundColor = .white
        addTarget(action.0, action: action.1, for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
        
        if icon != nil {
            iconView = UIImageView(image: icon)
            iconView!.translatesAutoresizingMaskIntoConstraints = false
            iconView!.isUserInteractionEnabled = false
            iconView!.contentMode = .scaleAspectFit
            iconView!.tintColor = Color.dark
            addSubviews(iconView!, label, chevron)
            NSLayoutConstraint.activate([
                
                heightAnchor.constraint(equalToConstant: 50),
                
                iconView!.centerYAnchor.constraint(equalTo: centerYAnchor),
                iconView!.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                iconView!.widthAnchor.constraint(equalToConstant: 20),
                iconView!.heightAnchor.constraint(equalToConstant: 20),
                
                
                label.topAnchor.constraint(equalTo: topAnchor),
                label.leadingAnchor.constraint(equalTo: iconView!.trailingAnchor, constant: 20),
                label.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                chevron.leadingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor, constant: 20),
                chevron.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                chevron.heightAnchor.constraint(equalToConstant: 20),
                chevron.widthAnchor.constraint(equalToConstant: 20),
                chevron.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
        } else {
            addSubviews(label, chevron)
            NSLayoutConstraint.activate([
                heightAnchor.constraint(equalToConstant: 50),
                
                label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
                
                chevron.leadingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor, constant: 20),
                chevron.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                chevron.heightAnchor.constraint(equalToConstant: 20),
                chevron.widthAnchor.constraint(equalToConstant: 20),
                chevron.centerYAnchor.constraint(equalTo: centerYAnchor),
                
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

public class SwitchCell: UIView {
    public var label = Label(style: Font.body)
    public var uiswitch: UISwitch = {
        let v = UISwitch()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.onTintColor = Color.accentColor
        return v
    }()
    
    public init(text: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        label.text = text
        
        addSubviews(label, uiswitch)
        
        NSLayoutConstraint.activate([
            
            heightAnchor.constraint(equalToConstant: 50),
            
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            uiswitch.leadingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor),
            uiswitch.centerYAnchor.constraint(equalTo: centerYAnchor),
            uiswitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class TextFieldCell: UIView {
    
    public let label = Label(style: Font.body, string: "Deposit amount")
    public let textField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        
        addSubviews(label, textField)
        
        NSLayoutConstraint.activate([
            
            heightAnchor.constraint(equalToConstant: 50),
            
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: label.trailingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


