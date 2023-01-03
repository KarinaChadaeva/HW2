//
//  ViewController.swift
//  HW2
//
//  Created by Карина Чадаева on 03.01.23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.layer.cornerRadius = 15
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
    }

    // Меняем цвет вью
    @IBAction func rgbSlider(_ sender: UISlider) {
        setColor()
        
        switch sender.tag {
        case 0: blueLabel.text = string(from: sender)
        case 1: greenLabel.text = string(from: sender)
        case 2: redLabel.text = string(from: sender)
        default: break
        }
    }
    
    private func setColor() {
        mainView.backgroundColor = UIColor(red: CGFloat(redSlider.value) / 255,
                                           green: CGFloat(greenSlider.value) / 255,
                                           blue: CGFloat(blueSlider.value) / 255,
                                           alpha: 1)
    }
    
    // Устанавливаем значение label в соответствии с value слайдеров
    @IBAction func setValue() {
        redLabel.text = string(from: redSlider)
        greenLabel.text = string(from: greenSlider)
        blueLabel.text = string(from: blueSlider)
    }
    
    // Вспомогательная функция
    private func string(from slider: UISlider) -> String {
        String(Int(slider.value))
    }
    
    // Настройка работы buttons
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

