//
//  ViewController.swift
//  AAA
//
//  Created by CGLAB on 2017/5/17.
//  Copyright © 2017年 MAP_First. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITextFieldDelegate{
    static var wordOneLine:Int = 17
    static var stringPageLine = 19
    static var backcolor:UIColor = colorCahnge(rgbValue: 0xFFFFFF)
    static var fontType:String = "Charter"
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    let smallestfont:Double = 17
    let biggestfont:Double = 22
    
    
    var dataObject: String = ""
    var textObject: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    static var fontSize:Double = 22.0
    @IBOutlet weak var textContent: UITextView!
    
    @IBOutlet weak var hideEditBtnOutlet: UIButton!
    @IBOutlet weak var editVeiw: UIView!
    func updateUIElements() {
        self.textContent.text = textObject
        textContent.font = UIFont(name: ViewController.fontType,size: CGFloat(ViewController.fontSize))
        
        textContent.backgroundColor = ViewController.backcolor
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fontAthelasOutlet.titleLabel?.font = UIFont(name: "Athelas",size: 17)
        fontCharterOutlet.titleLabel?.font = UIFont(name: "Charter", size: 17)
        fontSeravekOutlet.titleLabel?.font = UIFont(name: "Seravek", size: 17)
        // Do any additional setup after loading the view, typically from a nib.
        self.updateUIElements()
        
    }
    
    
    
    
    
    //隱藏editView
    @IBAction func hideEditViewBtn(_ sender: Any) {
        if(editVeiw.isHidden == false){
            editVeiw.isHidden = true
            hideEditBtnOutlet.isHidden = true
        }
    }
    //字型
    @IBOutlet weak var fontAthelasOutlet: UIButton!
    
    @IBOutlet weak var fontCharterOutlet: UIButton!
    
    @IBOutlet weak var fontSeravekOutlet: UIButton!
    
    
    
    @IBAction func fontCharter(_ sender: Any) {
        ViewController.fontType = "Charter"
        self.updateUIElements()
    }
    
    @IBAction func fontAthelas(_ sender: Any) {
        ViewController.fontType = "Athelas"
        self.updateUIElements()
    }
    
    @IBAction func fontGeorgia(_ sender: Any) {
        ViewController.fontType = "Georgia"
        self.updateUIElements()
    }
    
    @IBAction func fontPalatino(_ sender: Any) {
        ViewController.fontType = "Palatino"
        self.updateUIElements()
    }
    @IBAction func fontSeravek(_ sender: Any) {
        ViewController.fontType = "Seravek"
        self.updateUIElements()
    }
    @IBAction func fontTimesRoman(_ sender: Any) {
        ViewController.fontType = "Times New Roman"
        self.updateUIElements()
    }
    //編輯按鈕
    @IBAction func editBtn(_ sender: Any){
        if(editVeiw.isHidden){
            editVeiw.isHidden = false
            hideEditBtnOutlet.isHidden = false
        }else{
            editVeiw.isHidden = true
            hideEditBtnOutlet.isHidden = true
        }
    }
    
    //背景色
    @IBAction func BackgroundWhite(_ sender: Any) {
        ViewController.backcolor = ViewController.colorCahnge(rgbValue: 0xFFFFFF)
        updateUIElements()
        
    }
    @IBAction func BackGroundCream(_ sender: Any) {
        ViewController.backcolor = ViewController.colorCahnge(rgbValue: 0xFFEE99)
        updateUIElements()
    }
    
    //字體大小
    @IBAction func biggerFontSize(_ sender: Any) {
        if(ViewController.fontSize >= biggestfont){
            ViewController.fontSize = biggestfont
        }else{
            ViewController.wordOneLine -= 5
            ViewController.stringPageLine -= 6
            ViewController.fontSize += 5
        }
        textContent.font = UIFont(name: (textContent.font?.fontName)!,size: CGFloat(ViewController.fontSize))
    }
    
    
    
    @IBAction func smallerFontSize(_ sender: Any) {
        if(ViewController.fontSize <= smallestfont){
            ViewController.fontSize = smallestfont
        }else{
            ViewController.wordOneLine += 5
            ViewController.stringPageLine += 6
            ViewController.fontSize -= 5
        }
        textContent.font = UIFont(name: (textContent.font?.fontName)!,size: CGFloat(ViewController.fontSize))
    }
    
    //顏色處例
    static func colorCahnge(rgbValue: UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red: red, green: green, blue: blue, alpha: CGFloat(1))
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

