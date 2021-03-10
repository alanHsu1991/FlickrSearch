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
    @IBOutlet weak var searchButton: UIButton!
    
    var flickrManager = FlickrManager()
    var flickrDatas = [FlickrData]()
    
    let button = UIButton?.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchPictures.delegate = self
        numberOfPictures.delegate = self
        
        if ((searchPictures.text?.isEmpty) != nil), ((numberOfPictures.text?.isEmpty) != nil) {
            searchButton.isEnabled = false
        }
        
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        
        searchPictures.endEditing(true)
        numberOfPictures.endEditing(true)
        print(searchPictures.text!)
        print(numberOfPictures.text!)
        
        //let flickrView = FlickrPhotosViewController()
        //self.navigationController?.pushViewController(flickrView, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let flickrView = storyboard.instantiateViewController(identifier: "flickrView") as? FlickrPhotosViewController

        flickrView?.searchPictureText = searchPictures.text ?? ""
        flickrView?.numberOfPictureText = numberOfPictures.text ?? ""
    
        guard let existedView = flickrView else {return}
        self.navigationController?.pushViewController(existedView, animated: true)

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        if !text.isEmpty{
            searchButton.isEnabled = true
        } else {
            searchButton.isEnabled = false
        }
        return true
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
            FlickrManager.shared.fetchPicture1(theType: type, theNumber: number, completionHandler: {[weak self] (result) in
                self?.flickrDatas = result
                //print(self?.flickrDatas ?? "Error")
                DispatchQueue.main.async {
                    //self?.collectionView.reloadData()
                }
            })
        }

    }
    
}

