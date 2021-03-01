//
//  FlickrManager.swift
//  FlickrSearch
//
//  Created by Alan Hsu on 2021/2/23.
//

import Foundation

struct FlickrManager {
    let flickrURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=1804de219111a0a271dacbf6e9bbf97a&format=json&nojsoncallback=1"
    
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
//    if let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=dc968a9486be986c2c4cadf22a597027&text=sexy&per_page=20&format=json&nojsoncallback=1") {
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
