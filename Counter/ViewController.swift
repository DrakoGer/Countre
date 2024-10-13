//
//  ViewController.swift
//  Counter
//
//  Created by Yura on 12.10.24.
//

import UIKit

class ViewController: UIViewController {
    
    private var zero: Int = 0
    private var historiText: String = "История изменений"
    
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Значение счетчика: \(zero)"
        textView.isEditable = false
        historyLabel.text = historiText
    }
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        zero += 1
        
        addToHistory("Значение изменино на +1")
        updateScore()
        
        if zero > 0 {
            minusButton.isEnabled = true
            refreshButton.isEnabled = true
        }
    }
    
    @IBAction func minusButtonTapped(_ sender: Any) {
        if zero > 0 {
            zero -= 1
            
            addToHistory("Значение изменино на -1")
            updateScore()
        } else {
            addToHistory("Значение счётчика ниже 0, нельзя уменьшить ещё")
            minusButton.isEnabled = false
        }
    }
    
    @IBAction func refreshBuutonTapped(_ sender: Any) {
        if zero > 0 {
            zero = 0
            
            minusButton.isEnabled = false
            refreshButton.isEnabled = false

            addToHistory("Значение сброшено до 0")
            updateScore()
        } else {
            if zero >= 0 {
                addToHistory("Значение 0, нельзя сбросить")
                refreshButton.isEnabled = false
            }
        }
    }
    
    private func updateScore() {
        scoreLabel.text = "Значение счетчика: \(zero)"
        }
    
    private func addToHistory(_ message: String) {
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
