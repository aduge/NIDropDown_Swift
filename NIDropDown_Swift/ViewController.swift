//
//  ViewController.swift
//  NIDropDown_Swift
//
//  Created by BinqianDu on 8/28/15.
//  Copyright (c) 2015 Binqian Du. All rights reserved.
//

import UIKit

class ViewController: UIViewController,NIDropDelegate {

    @IBOutlet var button: UIButton!
    var dropDown:NIDropDown?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.grayColor().CGColor
        button.layer.cornerRadius = 5
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonClicked(sender: UIButton) {
        let array:Array<String> = ["hand","body","soul"]
        if (dropDown == nil){
            let f:CGFloat = 120
            dropDown = NIDropDown(button: sender,height: f,array: array)
            dropDown!.delegate = self
            
        }else{
            dropDown!.hideDropDown(sender as UIButton)
            self.rel()
        }
        
        
    }
    
    func niDropDownDelegateMethod(sender: NIDropDown) {
        println("you choose:\(sender.choosedString)")
        self.rel()
    }
    
     func rel() {
        dropDown = nil
    }

}

