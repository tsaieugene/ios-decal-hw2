//
//  KeyboardViewController.swift
//  CalKeyboard
//
//  Created by Gene Yoo on 9/15/15.
//  Copyright © 2015 iOS Decal. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    @IBOutlet var Display: UILabel!
    
    var keyboardView: UIView!
    
    var needToClear = true
    
    var first:Float = 0
    
    var second:Float = 0
    
    var operation = ""
    
    @IBAction func numberPressed(sender: AnyObject) {
        if needToClear{
            deleteDisplay()
            needToClear = false
        }
        if let numStr = sender.currentTitle {
            let numNSString = numStr! as NSString
            if let current = Display?.text! {
                Display.text = "\(current)\(numNSString.intValue)"
            } else {
                Display.text = "\(numNSString.intValue)"
            }
        }
    }
    
    
    @IBAction func operationPressed(sender: AnyObject) {
        first = Float(Display.text!)!
        operation = sender.currentTitle!!
        deleteDisplay()
    }
    
    @IBAction func returnPressed(sender: AnyObject) {
        second = Float(Display.text!)!
        var answer:Float = 0
        if operation == "+"{
            answer = first + second
        } else if operation == "-"{
            answer = first - second
        } else if operation == "*"{
            answer = first * second
        } else if operation == "/"{
            answer = first / second
        }
        Display.text = "\(answer)"
    }
    @IBAction func deletePressed(sender: AnyObject) {
        let textProxy = textDocumentProxy as UITextDocumentProxy
            textProxy.deleteBackward()
        deleteDisplay()
        needToClear = true
    }
    
    @IBAction func showPressed(sender: AnyObject) {
        let textProxy = textDocumentProxy as UITextDocumentProxy
        if let number = Display?.text as String? {
            textProxy.insertText(number)
        }
        deleteDisplay()
        needToClear = true
    }

    func deleteDisplay() {
        Display.text = ""
    }
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadInterface()
        deleteDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    }

    func loadInterface() {
        let keyboardNib = UINib(nibName: "Keyboard", bundle: nil)
        keyboardView = keyboardNib.instantiateWithOwner(self, options: nil)[0] as! UIView
        keyboardView.frame = view.frame
        view.addSubview(keyboardView)
        view.backgroundColor = keyboardView.backgroundColor
        nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside) // advanceToNextInputMode is already defined in template
        
    }


}
