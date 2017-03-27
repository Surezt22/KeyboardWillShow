//
//  ViewController.swift
//  KeyboardCodeSample
//
//  Created by James Rochabrun on 3/27/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //1 Create a view that will hold your TEXTFIELD
    let textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.borderColor = UIColor.darkGray.cgColor
        tf.layer.borderWidth = 3.0
        return tf
    }()
    //2 global variable that will hold the bottom constraint on changes
    var textfieldBottomAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        //3 add the view to your controller
        view.addSubview(textField)
        textField.heightAnchor.constraint(equalToConstant: 80).isActive = true
        textField.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        textField.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        textfieldBottomAnchor = textField.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        textfieldBottomAnchor?.isActive = true
        
        setUpKeyBoardObservers()
    }
    //4 Use NSnotificationCenter to monitor the keyboard updates
    func setUpKeyBoardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //5 toggle the bottom layout global variable based on the keyboard's height
    func handleKeyboardWillShow(notification: NSNotification) {
        
        let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect
        if let keyboardFrame = keyboardFrame {
            textfieldBottomAnchor?.constant = -keyboardFrame.height
        }
        let keyboardDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
        if let keyboardDuration = keyboardDuration {
            UIView.animate(withDuration: keyboardDuration, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func handleKeyboardWillHide(notification: NSNotification) {
        
        textfieldBottomAnchor?.constant = 0
        let keyboardDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
        if let keyboardDuration = keyboardDuration {
            UIView.animate(withDuration: keyboardDuration, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    //6 remove the observers
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }    
}

