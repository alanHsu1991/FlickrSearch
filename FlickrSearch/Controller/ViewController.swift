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
    var flickrDatas = [FlickrData]()
    
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
        
        //let flickrView = FlickrPhotosViewController()
        //self.navigationController?.pushViewController(flickrView, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let flickrView = storyboard.instantiateViewController(identifier: "flickrView") as? FlickrPhotosViewController

        flickrView?.searchPictureText = searchPictures.text ?? ""
        flickrView?.numberOfPictureText = numberOfPictures.text ?? ""
    
        guard let existedView = flickrView else {return}
        self.navigationController?.pushViewController(existedView, animated: true)

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

