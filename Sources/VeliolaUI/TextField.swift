//
//  TextField.swift
//  Veliola
//
//  Created by Tadreik Campbell on 6/5/21.
//  Copyright © 2021 Tadreik Campbell. All rights reserved.
//

import UIKit

public class TextField: UIView {
    
    private let l = Label(style: UIFont.systemFont(ofSize: 12))
    private let v = UITextField()
    public var placeholder: String = "" {
        didSet {
            if isRequired {
                l.text = "\(placeholder)*"
            }
            v.placeholder = placeholder
        }
    }
    public var text: String = "" {
        didSet {
            v.text = text
        }
    }
    public var textContentType: UITextContentType? = nil {
        didSet {
            v.textContentType = textContentType
        }
    }
    public var autocorrectionType: UITextAutocorrectionType = .default {
        didSet {
            v.autocorrectionType = autocorrectionType
        }
    }
    public var autocapitalizationType: UITextAutocapitalizationType = .none {
        didSet {
            v.autocapitalizationType = autocapitalizationType
        }
    }
    public var keyboardType: UIKeyboardType = .default {
        didSet {
            v.keyboardType = keyboardType
        }
    }
    public var isSecureTextEntry: Bool = false {
        didSet {
            v.isSecureTextEntry = isSecureTextEntry
        }
    }
    
    public var isRequired: Bool = true {
        didSet {
            l.text = placeholder
        }
    }
    
    public var returnKeyType: UIReturnKeyType = .default {
        didSet {
            v.returnKeyType = returnKeyType
        }
    }
    
    public var delegate: UITextFieldDelegate? {
        didSet {
            v.delegate = delegate
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = Font.body
        v.textColor = Color.dark
        v.borderStyle = .roundedRect
        v.layer.masksToBounds = true
        v.layer.cornerRadius = 10
        v.layer.borderWidth = 1
        v.layer.borderColor = Color.dark.cgColor
        v.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        addSubviews(l,v)
        NSLayoutConstraint.activate([
            l.topAnchor.constraint(equalTo: topAnchor),
            l.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            l.trailingAnchor.constraint(equalTo: trailingAnchor),
            v.topAnchor.constraint(equalTo: l.bottomAnchor, constant: 6),
            v.leadingAnchor.constraint(equalTo: leadingAnchor),
            v.trailingAnchor.constraint(equalTo: trailingAnchor),
            v.bottomAnchor.constraint(equalTo: bottomAnchor),
            v.heightAnchor.constraint(equalToConstant: 44),
            self.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func textFieldDidChange() {
        text = v.text ?? ""
    }
    
    public override func becomeFirstResponder() -> Bool {
        v.becomeFirstResponder()
    }
    
    public override func resignFirstResponder() -> Bool {
        v.resignFirstResponder()
    }
}
