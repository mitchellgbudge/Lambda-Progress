//
//  StarRating.swift
//  Progress
//
//  Created by Mitchell Budge on 11/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

extension UIView {
  // "Flare view" animation sequence
  func performFlare() {
    func flare()   { transform = CGAffineTransform(scaleX: 1.6, y: 1.6) }
    func unflare() { transform = .identity }
    
    UIView.animate(withDuration: 0.3,
                   animations: { flare() },
                   completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
  }
}

class StarRating: UIControl {
  
  var value: Int = 1
  
  // MARK: - Component characteristics
  
  private let componentDimension: CGFloat = 60.0
  private let componentCount = 3
  private let componentActiveColor = UIColor.yellow
  private let componentInactiveColor = UIColor.gray
  private var components: [UILabel] = []

  // MARK: - Auto Layout
  
  override var intrinsicContentSize: CGSize {
    let componentsWidth = CGFloat(componentCount) * componentDimension
    let componentsSpacing = CGFloat(componentCount + 1) * 8.0
    let width = componentsWidth + componentsSpacing
    return CGSize(width: width, height: componentDimension)
  }

  // MARK: - Initialization
  /// Sets up custom control view
  func setup() {
    backgroundColor = .clear
    frame = CGRect(origin: .zero, size: intrinsicContentSize)
    for index in 1 ... componentCount {
      // Create label
      let label = UILabel()
      addSubview(label)
      components.append(label)

      // Lay out label
      let offset = CGFloat(index - 1) * componentDimension + CGFloat(index) * 8.0
      let origin = CGPoint(x: offset , y: 0)
      let componentSize = CGSize(width: componentDimension, height: componentDimension)
      label.frame = CGRect(origin: origin, size: componentSize)
      label.tag = index // the control's value for that component
      // Setup label
      label.font = UIFont.boldSystemFont(ofSize: 40)
      label.text = "⭑"
      label.textAlignment = .center
      switch index {
      case 1:  label.textColor = componentActiveColor
      default: label.textColor = componentInactiveColor
      }
    }
  }
  
  required init?(coder aCoder: NSCoder) {
    super.init(coder: aCoder)
    setup()
  }
  
  // MARK: - Interaction
  
  func updateValue(at touch: UITouch) {
    // Store the old value to help control whether
    // the target is notified about an updated value
    let oldValue = value
    
    // Calculate the value at the current touch
    let touchPoint = touch.location(in: self)
    for component in components {
      if component.frame.contains(touchPoint) && component.tag != value {
        // Update value
        value = component.tag
        
        // Update visuals
        for index in 1 ... componentCount {
          switch index <= value {
          case true:
            components[index - 1].textColor = componentActiveColor
          case false:
            components[index - 1].textColor = componentInactiveColor
          }
        }
        
        // Perform view flare
        component.performFlare()
      }
    }

    // Only send action if the value changes to
    // prevent unnecessary load on control's target
    if value != oldValue {
      sendActions(for: .valueChanged)
    }
  }
  
  // Start tracking touch in control
  override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    updateValue(at: touch)
    return true
  }
  
  // Continue tracking touch in control
  override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    let touchPoint = touch.location(in: self)
    if bounds.contains(touchPoint) {
      updateValue(at: touch)
      sendActions(for: .touchDragInside)
    } else {
      sendActions(for: .touchDragOutside)
    }
    return true
  }
  
  // End tracking touch in control
  override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
    guard let touch = touch else {
      NSLog("Unable to track touch")
      return
    }
    
    let touchPoint = touch.location(in: self)
    if bounds.contains(touchPoint) {
      updateValue(at: touch)
      sendActions(for: .touchUpInside)
    } else {
      sendActions(for: .touchUpOutside)
    }
  }
  
  // Cancel tracking
  override func cancelTracking(with event: UIEvent?) {
    sendActions(for: .touchCancel)
  }
}
