//
//  ServiceRequest.swift
//  SampleVideo
//
//  Created by Nikhil Challagulla on 10/20/17.
//  Copyright © 2017 Nikhil Challagulla. All rights reserved.
//

import UIKit

class ServiceRequest: NSObject {
    
    func requestForVideos(value: NSString){
        
        let url = URL(string: "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet%2CcontentDetails&maxResults=50&playlistId=UUpRmvjdu3ixew5ahydZ67uA&key=AIzaSyCeuFbFOn81HYnjmCQ-eRdDKPOpuC0mHzo")
        let task = URLSession.shared.dataTask(with: url! as URL) { data, response, error in
            if error != nil {
                print(error!)
            } else {
                if let urlContent = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                        print(jsonResult["items"] ?? NSArray())
                        _ = jsonResult["items"] ?? NSArray()
//                        if jsonArray.count > 0
//                        {
//                            print("************ RESPONSE IS: ************")
//                            print(jsonResult)
//                        } else {
//                        }
                    } catch {
                        print("************ JSON SERIALIZATION ERROR ************")
                    }
                }
                
            }

        }
        task.resume()
        
        
    }

}
