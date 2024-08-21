
#!/bin/bash

# Configuration
TARGET_NAME="YourTargetName"
COUNTRY_CODE="US"  # Change to the desired country code
PLIST_PATH="./${TARGET_NAME}/Info.plist"  # Path to your Info.plist
BUILD_NUMBER=$(($(xcodebuild -target "$TARGET_NAME" -showBuildSettings | grep CURRENT_PROJECT_VERSION | awk '{print $3}') + 1))

# Update Info.plist with new country code
/usr/libexec/PlistBuddy -c "Set :COUNTRY_CODE ${COUNTRY_CODE}" "$PLIST_PATH"

# Update build number
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion ${BUILD_NUMBER}" "$PLIST_PATH"

echo "Country code updated to ${COUNTRY_CODE}."
echo "Build number updated to ${BUILD_NUMBER}."

# Optional: Build the project
xcodebuild -target "$TARGET_NAME"


#!/bin/bash

# Ensure the script is run with a target name
if [ $# -ne 1 ]; then
    echo "Usage: $0 <target>"
    echo "Available targets: A, B, C"
    exit 1
fi

# Assign the target from the argument
TARGET=$1
PROJECT_PATH="path/to/your/project.xcodeproj"

# Validate the target
if [[ "$TARGET" != "A" && "$TARGET" != "B" && "$TARGET" != "C" ]]; then
    echo "Error: Invalid target. Available targets: A, B, C."
    exit 1
fi

# Define the scheme corresponding to the target
SCHEME="${TARGET}Scheme"

# Print out the scheme for debugging
echo "Using scheme '$SCHEME' for target '$TARGET'..."

# Check if the scheme exists
if ! xcodebuild -project "$PROJECT_PATH" -scheme "$SCHEME" -showBuildSettings >/dev/null 2>&1; then
    echo "Error: Scheme '$SCHEME' not found in project."
    echo "Please verify that the scheme '$SCHEME' exists in your Xcode project."
    exit 1
fi

# Optionally, you can set the scheme in Xcode project settings
# Here, we'll simply build with the specified scheme to confirm it's working
xcodebuild -project "$PROJECT_PATH" -scheme "$SCHEME" -configuration Debug clean build

if [ $? -eq 0 ]; then
    echo "Successfully switched to scheme '$SCHEME' for target '$TARGET'."
else
    echo "Failed to switch to scheme '$SCHEME'."
    exit 1
fi
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
