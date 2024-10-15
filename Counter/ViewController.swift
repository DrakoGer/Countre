//
//  ViewController.swift
//  Counter
//
//  Created by Yura on 12.10.24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var historyLabel: UILabel!
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var counterLabel: UILabel!
    
    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var refreshButton: UIButton!
    
    private var counterValue: Int = 0
    private var historyText: String = "История изменений"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counterLabel.text = "Значение счетчика: \(counterValue)"
        textView.isEditable = false
        historyLabel.text = historyText
    }
    
    @IBAction private func plusButtonTapped(_ sender: Any) {
        counterValue += 1
        
        UpdateHistory("Значение изменено на +1")
        updateCounterValue()
        
        if counterValue > 0 {
            minusButton.isEnabled = true
            refreshButton.isEnabled = true
        }
    }
    
    @IBAction private func minusButtonTapped(_ sender: Any) {
        if counterValue > 0 {
            counterValue -= 1
            
            UpdateHistory("Значение изменено на -1")
            updateCounterValue()
        } else {
            UpdateHistory("Значение счётчика ниже 0, нельзя уменьшить ещё")
            minusButton.isEnabled = false
        }
    }
    
    @IBAction private func refreshButtonTapped(_ sender: Any) {
        if counterValue > 0 {
            counterValue = 0
            
            minusButton.isEnabled = false
            refreshButton.isEnabled = false
            
            UpdateHistory("Значение сброшено до 0")
            updateCounterValue()
        } else {
            if counterValue >= 0 {
                UpdateHistory("Значение 0, нельзя сбросить")
                refreshButton.isEnabled = false
            }
        }
    }
    
    private func updateCounterValue() {
        counterLabel.text = "Значение счетчика: \(counterValue)"
    }
    
    private func UpdateHistory(_ message: String) {
        let timeMessage = getCurrentTimestamp()
        textView.text = (textView.text ?? "") + "\n[\(timeMessage)]: \(message)"
        
        let bottom = NSMakeRange(textView.text.count - 1, 1)
        textView.scrollRangeToVisible(bottom)
    }
    
    private func getCurrentTimestamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        return dateFormatter.string(from: Date())
    }
}
