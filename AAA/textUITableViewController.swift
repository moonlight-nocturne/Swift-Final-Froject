//
//  textUITableViewController.swift
//  AAA
//
//  Created by Mac on 2017/5/20.
//  Copyright © 2017年 MAP_First. All rights reserved.
//

import UIKit

class textUITableViewController: UITableViewController,UITextFieldDelegate{
    static var selectText:String = ""
    
    //File manipulation
    var noteTitles:[String] = PureTextNote.titleOfSavedNotes()
    func updateNoteTitles() {
        self.noteTitles = PureTextNote.titleOfSavedNotes()
    }
    var newNote = PureTextNote()
    var cont:String = ""
    var tit: String = ""
    //File manipulation
    
    private var myTextField: UITextField!
    private var fileNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return self.noteTitles.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textTitleCell", for: indexPath)
        let noteTitle = cell.viewWithTag(1000) as! UILabel//table cell的標頭
        noteTitle.text = self.noteTitles[indexPath.row] as String
        return cell
    }
    

    //使用者選擇的table欄位時紀錄選的是哪一欄
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectFile = noteTitles
        textUITableViewController.selectText = selectFile[indexPath.row]
        
        
    }
    
    
    
    //Read File
    @IBAction func readAlink(_ sender: Any) {
        // UITextFieldの配置するx,yと幅と高さを設定.
        let tWidth: CGFloat = 200
        let tHeight: CGFloat = 30
        let posX: CGFloat = (self.view.bounds.width - tWidth)/2
        let posY: CGFloat = (self.view.bounds.height - tHeight)/4
        let posY2: CGFloat = (self.view.bounds.height - tHeight)/5
        // UITextFieldを作成する.
        myTextField = UITextField(frame: CGRect(x: posX, y: posY, width: tWidth, height: tHeight))
        fileNameField = UITextField(frame: CGRect(x: posX, y: posY2, width: tWidth, height: tHeight))
        // 表示する文字を代入する.
        myTextField.text = "https://cdn.fbsbx.com/v/t59.2708-21/18219948_1324960664207908_5163162044026847232_n.txt/the-ultimate-crisis.txt?oh=c9c901a49bd0a16f661ab3cafa37d6ca&oe=59411496&dl=1"
        fileNameField.text = "File Name"
        // Delegateを自身に設定する
        myTextField.delegate = self
        fileNameField.delegate = self
        // 枠を表示する.
        myTextField.borderStyle = .roundedRect
        fileNameField.borderStyle = .roundedRect
        // クリアボタンを追加.
        myTextField.clearButtonMode = .whileEditing
        myTextField.backgroundColor = UIColor.lightGray
        myTextField.tag = 1001
        fileNameField.clearButtonMode = .whileEditing
        fileNameField.backgroundColor = UIColor.lightGray
        fileNameField.tag = 1002
        // Viewに追加する
        self.view.addSubview(myTextField)
        self.view.addSubview(fileNameField)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing: \(textField.text!)")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1002{
            self.newNote.title = textField.text!
        }
        print("textFieldDidEndEditing: \(textField.text!)")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn \(textField.text!)")
        // 改行ボタンが押されたらKeyboardを閉じる処理.
        textField.resignFirstResponder()
        let readIn = self.myTextField.text
        if self.fileNameField.text != "cancel"{
            print(readIn!)
            //let test = "https://cdn.fbsbx.com/v/t59.2708-21/18219948_1324960664207908_5163162044026847232_n.txt/the-ultimate-crisis.txt?oh=c9c901a49bd0a16f661ab3cafa37d6ca&oe=59411496&dl=1"
            do{
                try readContent(link: URL(string:readIn!)!)
            }
            catch{
                print("Read file error")
            }
        }
        if let viewWithTag = self.view.viewWithTag(1001) {
            viewWithTag.removeFromSuperview()
        }else{
            print("No! 1001")
        }
        if let viewWithTag = self.view.viewWithTag(1002) {
            viewWithTag.removeFromSuperview()
        }else{
            print("No! 1002")
        }
        return true
    }
    func readContent(link:URL){
        cont = try! String(contentsOf: link)
        self.newNote.content = cont
        self.newNote.title = self.fileNameField.text!
        if (self.newNote.title == ""){
            self.newNote.title = PureTextNote.defaultTitle()
        }
        try? self.newNote.save()
        self.updateNoteTitles()
        if self.isViewLoaded {
            self.tableView.reloadData()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OpenFile" {
            guard let cell = sender as? UITableViewCell else {
                fatalError("Mis-configured storyboard! The sender should be a cell.")
            }
            self.prepareOpeningFile(for: segue, sender: cell)
        }else {
            super.prepare(for: segue, sender: sender)
        }
    }
    func prepareOpeningFile(for segue: UIStoryboardSegue, sender: UITableViewCell) {
        let senderIndexPath = self.tableView.indexPath(for: sender)!
        let selectedTitle = self.noteTitles[senderIndexPath.row]
        ModelController.filename = selectedTitle
    }
    //Read File
}
