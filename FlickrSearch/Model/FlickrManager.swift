//
//  FlickrManager.swift
//  FlickrSearch
//
//  Created by Alan Hsu on 2021/2/23.
//

import Foundation

struct FlickrManager {
    let flickrURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=ee25a6347d43e4acefcf96df57cce47a&format=json&nojsoncallback=1"
    
    func fetchPicture(theType: String, theNumber: String){
        let urlString = "\(flickrURL)&text=\(theType)&per_page=\(theNumber)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        //1. Create a URL
        if let url = URL(string: urlString){
            
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(flickrData: safeData)
                }
            }
            
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(flickrData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(SearchData.self, from: flickrData)
            print(decodedData.photos.photo)
        } catch {
            print(error)
        }
    }
    
}

// text=sexy

//var photos = [Photo]()
//
//func fetchData() {
//
//
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let data = data, let searchData = try? JSONDecoder().decode(SearchData.self, from: data){
//                photos = searchData.photos.photo
//            }
//
//        }
//
//    }
//
//}
