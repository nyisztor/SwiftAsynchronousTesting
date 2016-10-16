//
//  Downloader.swift
//  Downloader
//
//  Created by Károly Nyisztor on 2016. 10. 15..
//  Copyright © 2016. www.leakka.com. All rights reserved.
//

import Foundation

public class Downloader {
    
    fileprivate static let session = URLSession(configuration: URLSessionConfiguration.default)
    
    fileprivate static let syncQueue = DispatchQueue(label: "Downloader.syncQueue")
    
    public static func download( from url: URL, completionHandler:@escaping (URL?, URLResponse?, Error?) -> Void ) {
        
        syncQueue.sync {
            
            let downloadTask = session.downloadTask(with: url, completionHandler: completionHandler)
            downloadTask.resume()
        }
    }
}
