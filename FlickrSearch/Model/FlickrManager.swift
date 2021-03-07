//
//  FlickrManager.swift
//  FlickrSearch
//
//  Created by Alan Hsu on 2021/2/23.
//

import Foundation

struct FlickrManager {
    
    static let shared = FlickrManager()
    
    let flickrURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=65299428dd5bb14233f37ccb1170b3c1&format=json&nojsoncallback=1"
    
    func fetchPicture1(theType: String, theNumber: String, completionHandler: @escaping (_ flickrDatas: [FlickrData]) -> Void) {
        let urlString = "\(flickrURL)&text=\(theType)&per_page=\(theNumber)"
        
        //1. Create a URL
        if let url = URL(string: urlString) {
            
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(SearchData.self, from: safeData)
                        print(decodedData.photos.photo)
                        completionHandler(decodedData.photos.photo)
                    } catch {
                        print(error)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
}
    
//    func fetchPicture(theType: String, theNumber: String){
//        let urlString = "\(flickrURL)&text=\(theType)&per_page=\(theNumber)"
//        //performRequest(urlString: urlString, completionHandler: <#([FlickrData]) -> Void#>)
//    }
//
//    func performRequest(urlString: String, completionHandler: @escaping (_ flickrDatas: [FlickrData]) -> Void){
//
//        //1. Create a URL
//        if let url = URL(string: urlString){
//
//            //2. Create a URLSession
//            let session = URLSession(configuration: .default)
//
//            //3. Give the session a task
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error != nil {
//                    print(error!)
//                    return
//                }
//
//                if let safeData = data {
//                    let decoder = JSONDecoder()
//                    do {
//                        let decodedData = try decoder.decode(SearchData.self, from: safeData)
//                        print(decodedData.photos.photo)
//                        completionHandler(decodedData.photos.photo)
//                    } catch {
//                        print(error)
//                    }
//                }
//            }
//            //4. Start the task
//            task.resume()
//        }
//    }
//
//    func parseJSON(flickrData: Data) {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(SearchData.self, from: flickrData)
//            print(decodedData.photos.photo[0])
//        } catch {
//            print(error)
//        }
//    }




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
