//
//  FlickrData.swift
//  FlickrSearch
//
//  Created by Alan Hsu on 2021/2/23.
//

import Foundation

struct FlickrData: Decodable {

    let id: String
    let secret: String
    let server: String
    let farm: Int
    let title: String

    var imageURL: URL {
        return URL(string: "https://live.staticflickr.com/\(server)/\(id)_\(secret)_m.jpg")!
    }
}

struct PhotoData: Decodable {

    let photo: [FlickrData]

}

struct SearchData: Decodable {

    let photos: PhotoData

}


//        "id": "50975640647",
//        "owner": "139987286@N08",
//        "secret": "e475481722",
//        "server": "65535",
//        "farm": 66,
//        "title": "Decorating...",
//

