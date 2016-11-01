//
//  KCDatePickerButton.swift
//  KCPickerKit
//
//  Created by Kan Chen on 10/31/16.
//  Copyright © 2016 kcPickerKit. All rights reserved.
//

import UIKit

@objc public protocol KCDatePickerButtonDelegate {
    @objc optional func datePickerButtonDateDidChanged(_ button: KCDatePickerButton)
}

open class KCDatePickerButton: UIButton {
    override open var canBecomeFirstResponder: Bool { return true }
    override open var inputAccessoryView: UIView? { return datePickerAccessoryToolbar }
    override open var inputView: UIView? { return datePicker }
    /// DatePicker embeded in inputView
    public var datePicker = UIDatePicker()
    /// AccessoryView for DatePicker, default implementation has "Today" and "Done" Button
    public var datePickerAccessoryToolbar: UIToolbar = UIToolbar()
    /// DateFormatter: used when display the title
    public var dateDisplayFormat: String = "MM/dd/yyyy"

    public weak var delegate: KCDatePickerButtonDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.defaultSetup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultSetup()
    }

    private func defaultSetup() {
        // setup toolbar
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: self,
                                         action: #selector(doneButtonTapped))
        let todayButton = UIBarButtonItem(title: "Today",
                                          style: .plain,
                                          target: self,
                                          action: #selector(todayButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        datePickerAccessoryToolbar.items = [todayButton, flexibleSpace, doneButton]
        datePickerAccessoryToolbar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        datePickerAccessoryToolbar.backgroundColor = UIColor(red: 216/255.0, green: 216/255.0, blue: 216/255.0, alpha: 1)
        // setup datePicker
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        datePicker.datePickerMode = .date
    }

    func doneButtonTapped(_ sender: Any) {
        self.resignFirstResponder()
    }

    func todayButtonTapped(_ sender: Any) {
        datePicker.date = Date()
        datePickerValueChanged(datePicker)
    }

    func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateDisplayFormat
        setTitle(dateFormatter.string(from: sender.date), for: .normal)
        delegate?.datePickerButtonDateDidChanged?(self)
    }
}
