//
//  CustomStepper.swift
//  Ecom
//
//  Created by Arpit Singh on 20/06/21.
//

import UIKit

class PlainStepperControl: UIView {
    let datalabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "0"
        label.textColor = .black
        return label
    }()
    
    private let incrementButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add"), for: .normal)
        return button
    }()
    
    private let decrementButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "subtract"), for: .normal)
        return button
    }()
    
    var incrementAction: (() -> Void)?
    var decrementAction: (() -> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        let stack = UIStackView(arrangedSubviews: [incrementButton, datalabel, decrementButton])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 8
        backgroundColor = .plaingray
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        layer.cornerRadius = 5
        addSubview(stack)
        stack.addTopAnchor(equal: topAnchor)
            .addLeftAnchor(equal: leftAnchor, constant: 10)
            .addRightAnchor(equal: rightAnchor, constant: -10)
            .addBottomAnchor(equal: bottomAnchor)
        decrementButton.addTarget(self, action: #selector(stepperDecrementAction), for: .touchUpInside)
        incrementButton.addTarget(self, action: #selector(stepperIncrementAction), for: .touchUpInside)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func stepperIncrementAction() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        incrementAction?()
    }
    
    @objc func stepperDecrementAction() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
        decrementAction?()
    }
}
