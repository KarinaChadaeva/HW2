//
//  ViewController.swift
//  HW2
//
//  Created by Карина Чадаева on 03.01.23.
//

import UIKit

protocol EditViewControllerDelegate: AnyObject {
    func setColorOfView(color: UIColor)
}

class EditViewController: UIViewController {
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    
    //MARK: Private Properties
    weak var delegate: EditViewControllerDelegate?
    var viewColor: UIColor!
    let button = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.layer.cornerRadius = 15
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        mainView.backgroundColor = viewColor
        
        setSliders()
        addDoneButton(to: redTextField, greenTextField, blueTextField)
    }
    
    //MARK: - IBActions
    @IBAction func rgbSlider(_ sender: UISlider) {
        setColor()
        
        switch sender.tag {
        case 0:
            blueLabel.text = string(from: sender)
            blueTextField.text = string(from: sender)
        case 1:
            greenLabel.text = string(from: sender)
            greenTextField.text = string(from: sender)
        case 2:
            redLabel.text = string(from: sender)
            redTextField.text = string(from: sender)
        default: break
        }
    }
    
    @IBAction func setValue() {
        redLabel.text = string(from: redSlider)
        redTextField.text = string(from: redSlider)
            
        greenLabel.text = string(from: greenSlider)
        greenTextField.text = string(from: greenSlider)
            
        blueLabel.text = string(from: blueSlider)
        blueTextField.text = string(from: blueSlider)
    }
    
    
    @IBAction func doneButtonPressed() {
        delegate?.setColorOfView(color: mainView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    
    //MARK: - Private Methods
    private func setColor() {
        mainView.backgroundColor = UIColor(red: CGFloat(redSlider.value) / 255,
                                           green: CGFloat(greenSlider.value) / 255,
                                           blue: CGFloat(blueSlider.value) / 255,
                                           alpha: 1)
    }
    
    private func addDoneButton(to textFields: UITextField...) {
        
        textFields.forEach { textField in
            let keyboardToolbar = UIToolbar()
            textField.inputAccessoryView = keyboardToolbar
            keyboardToolbar.sizeToFit()
            
            let doneButton = UIBarButtonItem(
                title:"Done",
                style: .done,
                target: self,
                action: #selector(didTapDone)
            )
            
            let flexBarButton = UIBarButtonItem(
                barButtonSystemItem: .flexibleSpace,
                target: nil,
                action: nil
            )
            
            keyboardToolbar.items = [flexBarButton, doneButton]
        }
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func string(from slider: UISlider) -> String {
        String(Int(slider.value))
    }
    
    private func setSliders() {
        let ciColor = CIColor(color: viewColor)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
}
    
    
    //MARK: Buttons Actions
extension EditViewController {
    
    @IBAction func setWhite() {
        redSlider.value = 255
        greenSlider.value = 255
        blueSlider.value = 255
        setColor()
        setValue()
    }
    
    @IBAction func setBlack() {
        redSlider.value = 0
        greenSlider.value = 0
        blueSlider.value = 0
        setColor()
        setValue()
    }
    
    @IBAction func setRandomColor() {
        redSlider.value = Float.random(in: 0...255)
        greenSlider.value = Float.random(in: 0...255)
        blueSlider.value = Float.random(in: 0...255)
        setColor()
        setValue()
    }
}

//MARK: - UITextFieldDelegate
extension EditViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if let currentValue = Int(text), currentValue >= 0 && currentValue <= 255 {
            redTextField.tag = 1
            greenTextField.tag = 2
            blueTextField.tag = 3
            
            switch textField.tag {
            case 1:
                redSlider.value = Float(currentValue)
                redLabel.text = String(currentValue)
            case 2:
                greenSlider.value = Float(currentValue)
                greenLabel.text = String(currentValue)
            case 3:
                blueSlider.value = Float(currentValue)
                blueLabel.text = String(currentValue)
            default: break
            }
            
            setColor()
            return
        }
        showAlert(title: "Wrong format!", message: "Please, enter the value between 0 and 255")
    }
}
