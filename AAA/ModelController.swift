//
//  ModelController.swift
//  AAA
//
//  Created by Mac on 2017/6/5.
//  Copyright © 2017年 MAP_First. All rights reserved.
//

import UIKit

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


class ModelController: NSObject, UIPageViewControllerDataSource {
    
    
    var textOneLineLength = ViewController.wordOneLine
    var textPageLineNumber = ViewController.stringPageLine
    
    var rawData: String = ""
    var lineData: [String] = []
    var onePageData :String = ""
    var pageData: [String] = []
    //public static var pageData: [String] = []
    static var filename = ""
    
    var textData: [String] = []
    
    override init() {
        super.init()
        
        let storageURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let aaa = storageURL.appendingPathComponent("\(ModelController.filename).txt")
        if let path = Bundle.main.path(forResource: "狼與辛香料第一集片段", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: aaa.path, encoding: .utf8)
                let myStrings = data.components(separatedBy: .newlines)
                rawData = myStrings.joined(separator: "\n")
            } catch {
                print(error)
            }
            print("load file finished")
        }
        
        let rawDataLineArr = rawData.characters.split{$0 == "\n"}.map(String.init)
        
        for rawLine in rawDataLineArr{
            print("====================")
            print(rawLine)
            print(rawLine.characters.count)
            
            var str :String = rawLine
            while str != "" {
                let strLen = str.characters.count;
                if strLen >= textOneLineLength {
                    let index = str.index(str.startIndex, offsetBy: textOneLineLength)
                    //print(str.substring(to: index))
                    lineData.append(str.substring(to: index))
                    str = String( str.characters.suffix( strLen - textOneLineLength ))
                }
                else{
                    //print(str);
                    lineData.append(str)
                    str = ""
                    lineData.append(" ")
                }
            }
            //print(textLabel.sizeToFit(fullNameArr[i]))
            //print(ModelController.pageData)
        }
        /*
         for line in lineData{
         print(line)
         }
         */
        print("line Data Count: ")
        print(lineData.count)
        let totalPageNumber = Int( lineData.count / textPageLineNumber ) + 1
        print("Total Page Number: ")
        print(totalPageNumber)
        
        for i in 0...totalPageNumber-2 {
            onePageData = ""
            for j in 0...textPageLineNumber-1 {
                onePageData.append(lineData[i*textPageLineNumber+j])
                onePageData.append("\n")
                //pageData[i].append(lineData[i*23+j])
            }
            pageData.append(onePageData)
        }
        onePageData = ""
        for i in (totalPageNumber-1)*textPageLineNumber...lineData.count-1{
            onePageData.append(lineData[i])
            onePageData.append("\n")
        }
        for _ in 0...textPageLineNumber{
            onePageData.append("\n")
        }
        //onePageData.append("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
        pageData.append(onePageData)
        
    }
    
    func viewControllerAtIndex(_ index: Int, storyboard: UIStoryboard) -> ViewController? {
        // Return the data view controller for the given index.
        if (pageData.count == 0) || (index >= pageData.count) {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let dataViewController = storyboard.instantiateViewController(withIdentifier: "TextViewController") as! ViewController
        dataViewController.dataObject = "狼與辛香料第一集片段"
        dataViewController.textObject = pageData[index]
        return dataViewController
    }
    
    func indexOfViewController(_ viewController: ViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        return pageData.index(of: viewController.textObject) ?? NSNotFound
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! ViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! ViewController)
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        if index == pageData.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
}

