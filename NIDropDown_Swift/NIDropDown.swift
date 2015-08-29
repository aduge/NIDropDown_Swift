//
//  NIDropDown.swift
//  NIDropDown_Swift
//
//  Created by BinqianDu on 8/28/15.
//  Copyright (c) 2015 Binqian Du. All rights reserved.
//

import UIKit
import QuartzCore
import Foundation

protocol NIDropDelegate {
    
    func niDropDownDelegateMethod(sender: NIDropDown)
    
}

class NIDropDown: UIView,UITableViewDelegate,UITableViewDataSource {

    var delegate: NIDropDelegate?
    var choosedString:String?
    private var table: UITableView?
    private var btnSender: UIButton?
    private var list: Array<String>?
    
    override init() {
        super.init()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        
    }
    
    convenience init(button:UIButton,height:CGFloat,array:Array<String>) {
        self.init()
        self.showDropDown(b: button, height: height, array: array)
    }
   
    
    func showDropDown(#b: UIButton, height: CGFloat , array: Array<String>)
    {
        btnSender = b
        
        let btn: CGRect = b.frame
        self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0)
        self.list = array
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSizeMake(-5, 5)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        
        table = UITableView(frame: CGRectMake(0, 0, btn.size.width, 0))
        table?.delegate = self
        table?.dataSource = self
        table?.layer.cornerRadius = 5
        table?.backgroundColor = UIColor(red: 0.239, green: 0.239, blue: 0.239, alpha: 1)
        self.table!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")//must
      

        
        UIView.beginAnimations(nil , context: nil)
        UIView.setAnimationDuration(0.5)
        self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, height)
        table?.frame = CGRectMake(0, 0, btn.size.width, height)
        UIView.commitAnimations()
        b.superview?.addSubview(self)
        self.addSubview(table!)
       
        
    }
    
    
    
    func hideDropDown(b: UIButton)
    {
        let btn :CGRect = b.frame
        
        UIView.beginAnimations(nil , context: nil)
        UIView.setAnimationDuration(0.5)
        self.frame = CGRectMake(btn.origin.x, btn.origin.y+btn.size.height, btn.size.width, 0)
        table?.frame = CGRectMake(0, 0, btn.size.width, 0)
        UIView.commitAnimations()

        
    }
    
    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>tablevie>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list!.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
         let cell = tableView .dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
         cell.textLabel?.text = list![indexPath.row] as String
         cell.textLabel?.font = UIFont.systemFontOfSize(15)
         cell.textLabel?.textAlignment = .Center
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.hideDropDown(btnSender!)
        let cell:UITableViewCell = table!.cellForRowAtIndexPath(indexPath)!
        btnSender!.setTitle(cell.textLabel?.text, forState: UIControlState.Normal)
        self.choosedString = list![indexPath.row]
        self.delegate?.niDropDownDelegateMethod(self)
    }


}



