//
//  ScreenViewController.swift
//  HW2
//
//  Created by Карина Чадаева on 14.02.23.
//

import UIKit

class ScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editVC = segue.destination as! EditViewController
        editVC.delegate = self
        editVC.viewColor = view.backgroundColor
    }

    @IBAction func unwind(for segue: UIStoryboardSegue) {}
}

//MARK: Color Delegate
extension ScreenViewController: EditViewControllerDelegate {
    func setColorOfView(color: UIColor) {
        view.backgroundColor = color
    }
}
