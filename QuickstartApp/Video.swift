//
//  Video.swift
//  QuickstartApp
//
//  Created by Nikhil Challagulla on 10/20/17.
//

import UIKit

class Video : NSObject{

    var videoID :  Int = 0
    var channelName:String?
    var channelImage:UIImage
    
    init(videoID:Int,channelName:String,channelImage:UIImage){
         self.videoID       =  videoID
         self.channelName    =  channelName
         self.channelImage   =  channelImage
    }

 func  inituserDetail(sUser : NSDictionary) {
        self.videoID = sUser["videoId"] as Any as! Int
        self.channelName = (sUser["title"] as Any as! String)
        self.channelImage = (sUser["url"] as AnyObject) as! UIImage
    }
}
