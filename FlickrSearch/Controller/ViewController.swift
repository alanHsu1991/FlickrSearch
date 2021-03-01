//
//  ViewController.swift
//  FlickrSearch
//
//  Created by Alan Hsu on 2021/2/23.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var searchPictures: UITextField!
    @IBOutlet weak var numberOfPictures: UITextField!
    
    var flickrManager = FlickrManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchPictures.delegate = self
        numberOfPictures.delegate = self
        
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        
        searchPictures.endEditing(true)
        numberOfPictures.endEditing(true)
        print(searchPictures.text!)
        print(numberOfPictures.text!)
        
    }
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchPictures.endEditing(true)
        numberOfPictures.endEditing(true)
        print(searchPictures.text!)
        print(numberOfPictures.text!)
        return true
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type Something!"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let type = searchPictures.text, let number = numberOfPictures.text {
            flickrManager.fetchPicture(theType: type, theNumber: number)
        }
        
//        searchPictures.text = ""
//        numberOfPictures.text = ""
    }
    
}

