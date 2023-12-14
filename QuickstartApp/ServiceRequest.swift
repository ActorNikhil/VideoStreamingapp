//
//  ServiceRequest.swift
//  SampleVideo
//
//  Created by Nikhil Challagulla on 10/20/17.
//  Copyright © 2017 Nikhil Challagulla. All rights reserved.
//
import UIKit

class YourViewController: UIViewController {

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Your custom logic for handling memory warnings
        print("Received memory warning!")

        // Check memory usage
        if let memoryUsage = MemoryHelper.getMemoryUsage() {
            print("Memory Usage: \(memoryUsage) MB")
        }

        // Use Instruments for more detailed analysis
        DispatchQueue.global().async {
            self.recordMemoryUsage()
        }
    }

    func recordMemoryUsage() {
        let interval: TimeInterval = 5 // Set the interval for recording memory usage (seconds)
        let timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in
            // Use Instruments for more detailed memory analysis here
            // Example: Profile > Instruments > Allocations
            // You can set up additional instruments as needed
        }
        RunLoop.current.add(timer, forMode: .default)
    }
}

class MemoryHelper {
    static func getMemoryUsage() -> Double? {
        var taskInfo = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size)/4

        let kerr: kern_return_t = withUnsafeMutablePointer(to: &taskInfo) {
            taskInfoPointer in
            task_info(
                mach_task_self_,
                task_flavor_t(MACH_TASK_BASIC_INFO),
                taskInfoPointer.withMemoryRebound(to: Int32.self, capacity: 1) { $0 },
                &count
            )
        }

        if kerr == KERN_SUCCESS {
            let usedMemory = Double(taskInfo.resident_size) / (1024 * 1024)
            return usedMemory
        } else {
            return nil
        }
    }
}
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
