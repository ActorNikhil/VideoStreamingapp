//
//  AppDelegate.swift
//  QuickstartApp
//
//  Created by Nikhil Challagulla on 10/20/17.
//
import Foundation
import UserNotifications

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Request notification permissions
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                UNUserNotificationCenter.current().delegate = self
            }
        }
        
        // Schedule a notification
        let content = UNMutableNotificationContent()
        content.title = "My Notification"
        content.body = "This is a sample notification."
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "notificationIdentifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    // Delegate method called when a notification is triggered and the app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Handle the notification trigger here
        print("Notification will trigger: \(notification)")
        completionHandler([.alert, .sound, .badge])
    }
    
    // Delegate method called when a user interacts with a notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Handle the user's interaction with the notification here
        print("User interacted with notification: \(response.notification)")
        completionHandler()
    }
}
import UserNotifications

extension UNUserNotificationCenter {
    func removeDeliveredNotifications(withIdentifiers identifiers: [String], completion: @escaping (Error?) -> Void) {
        self.removeDeliveredNotifications(withIdentifiers: identifiers) { error in
            DispatchQueue.main.async {
                completion(error)
            }
        }
    }
}

// Usage
let notificationCenter = UNUserNotificationCenter.current()
let notificationIdentifiers: [String] = ["notification1", "notification2"]
notificationCenter.removeDeliveredNotifications(withIdentifiers: notificationIdentifiers) { error in
    if let error = error {
        print("Error removing delivered notifications with identifiers: \(error)")
    } else {
        print("Delivered notifications with identifiers removed successfully.")
    }
}
extension UNUserNotificationCenter {
    func removeDeliveredNotifications(withIdentifiers identifiers: [String], completion: @escaping (Error?) -> Void) {
        self.removeDeliveredNotifications(withIdentifiers: identifiers) { error in
            DispatchQueue.main.async {
                completion(error)
            }
        }
    }
}

// Usage
let notificationCenter = UNUserNotificationCenter.current()
let notificationIdentifiers: [String] = ["notification1", "notification2"]
notificationCenter.removeDeliveredNotifications(withIdentifiers: notificationIdentifiers) { error in
    if let error = error {
        print("Error removing delivered notifications with identifiers: \(error)")
    } else {
        print("Delivered notifications with identifiers removed successfully.")
    }
}
import UserNotifications

extension UNUserNotificationCenter {
    func removeDeliveredNotifications(withIdentifiers identifiers: [String], completion: @escaping (Error?) -> Void) {
        self.removeDeliveredNotifications(withIdentifiers: identifiers)
        { error in
            DispatchQueue.main.async {
                completion(error)
            }
        }
    }
}

// Usage
let notificationCenter = UNUserNotificationCenter.current()
let notificationIdentifiers: [String] = ["notification1", "notification2"]
notificationCenter.removeDeliveredNotifications(withIdentifiers: notificationIdentifiers) { error in
    if let error = error {
        print("Error removing delivered notifications with identifiers: \(error)")
    } else {
        print("Delivered notifications with identifiers removed successfully.")
    }
}

import UserNotifications

extension UNUserNotificationCenter {
    func removeAllDeliveredNotifications(completion: @escaping (Error?) -> Void) {
        self.removeAllDeliveredNotifications { error in
            DispatchQueue.main.async {
                completion(error)
            }
        }
    }
}

// Usage
let notificationCenter = UNUserNotificationCenter.current()
notificationCenter.removeAllDeliveredNotifications { error in
    if let error = error {
        print("Error removing delivered notifications: \(error)")
    } else {
        print("All delivered notifications removed successfully.")
    }
}


struct Person {
    let personId: Int
    let name: String
    let age: Int
    let addressId: Int
}

struct Address {
    let addressId: Int
    let street: String
    let city: String
}

func createCSVFile() {
    let persons = [
        Person(personId: 1, name: "John", age: 30, addressId: 1),
        Person(personId: 2, name: "Jane", age: 25, addressId: 2),
        Person(personId: 3, name: "Bob", age: 28, addressId: 3)
    ]
    
    let addresses = [
        Address(addressId: 1, street: "123 Main St", city: "New York"),
        Address(addressId: 2, street: "456 Elm St", city: "Los Angeles"),
        Address(addressId: 3, street: "789 Oak St", city: "Chicago")
    ]
    
    var csvString = "PersonId,Name,Age,AddressId,Street,City\n"

    for person in persons {
        if let address = addresses.first(where: { $0.addressId == person.addressId }) {
            csvString += "\(person.personId),\(person.name),\(person.age),\(person.addressId),\(address.street),\(address.city)\n"
        }
    }

    let fileName = "linked_data.csv"

    if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = documentDirectory.appendingPathComponent(fileName)

        do {
            try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
            print("CSV file with linked data created successfully.")
        } catch {
            print("Error creating CSV file: \(error.localizedDescription)")
        }
    }
}
import Foundation

func createCSVFile() {
    let csvString = "Name,Age,Email\n" +
                    "John,30,john@example.com\n" +
                    "Jane,25,jane@example.com\n" +
                    "Bob,28,bob@example.com"

    let fileName = "sample.csv"

    if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = documentDirectory.appendingPathComponent(fileName)

        do {
            try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
            print("CSV file created successfully.")
        } catch {
            print("Error creating CSV file: \(error.localizedDescription)")
        }
    }
}
func hexStringToByteArray(_ hexString: String) -> [UInt8]? {
    let len = hexString.count
    guard len % 2 == 0 else { return nil }
    
    var byteArray = [UInt8]()
    var index = hexString.startIndex
    
    for _ in 0..<len/2 {
        let nextIndex = hexString.index(index, offsetBy: 2)
        let byteString = hexString[index..<nextIndex]
        
        if let byte = UInt8(byteString, radix: 16) {
            byteArray.append(byte)
        } else {
            return nil
        }
        
        index = nextIndex
    }
    
    return byteArray
}

func createSineWaveArray(length: Int, amplitude: Int, frequency: Double) -> [Int] {
    var result = [Int]()
    for i in 0..<length {
        let value = Int(Double(amplitude) * sin(2 * Double.pi * frequency * Double(i) / Double(length)))
        result.append(value)
    }
    return result
}

// Usage example
let length = 100
let amplitude = 10
let frequency = 0.1

let sineWaveArray = createSineWaveArray(length: length, amplitude: amplitude, frequency: frequency)
print(sineWaveArray)

  let parabolicSignwave = parabolicSignwavePattern(range: integerRange, length: patternLength)
        print(parabolicSignwave)

  func parabolicSignwavePattern(range: ClosedRange<Int>, length: Int) -> [Int] {
        
        var pattern = [Int]()
        //    let pattern = (0..<length).map { index -> Int in
        for index in 0..<length {
            
            let t = Double(index) / Double(length - 1)
            let value = range.lowerBound + Int(Double((range.upperBound - range.lowerBound)) * pow((2 * t - 1), 2))
            pattern.append(value)
        }
        //   }
        return pattern
    }
▿ 60 elements
  - 0 : 175
  - 1 : 166
  - 2 : 157
  - 3 : 148
  - 4 : 140
  - 5 : 133
  - 6 : 125
  - 7 : 118
  - 8 : 111
  - 9 : 105
  - 10 : 98
  - 11 : 93
  - 12 : 87
  - 13 : 82
  - 14 : 77
  - 15 : 72
  - 16 : 68
  - 17 : 64
  - 18 : 60
  - 19 : 57
  - 20 : 54
  - 21 : 51
  - 22 : 48
  - 23 : 46
  - 24 : 44
  - 25 : 43
  - 26 : 41
  - 27 : 40
  - 28 : 40
  - 29 : 40
  - 30 : 40
  - 31 : 40
  - 32 : 40
  - 33 : 41
  - 34 : 43
  - 35 : 44
  - 36 : 46
  - 37 : 48
  - 38 : 51
  - 39 : 54
  - 40 : 57
  - 41 : 60
  - 42 : 64
  - 43 : 68
  - 44 : 72
  - 45 : 77
  - 46 : 82
  - 47 : 87
  - 48 : 93
  - 49 : 98
  - 50 : 105
  - 51 : 111
  - 52 : 118
  - 53 : 125
  - 54 : 133
  - 55 : 140
  - 56 : 148
  - 57 : 157
  - 58 : 166
  - 59 : 175


▿ 60 elements
  - 0 : 300
  - 1 : 291
  - 2 : 283
  - 3 : 275
  - 4 : 268
  - 5 : 261
  - 6 : 254
  - 7 : 247
  - 8 : 241
  - 9 : 235
  - 10 : 229
  - 11 : 224
  - 12 : 218
  - 13 : 214
  - 14 : 209
  - 15 : 205
  - 16 : 201
  - 17 : 197
  - 18 : 193
  - 19 : 190
  - 20 : 187
  - 21 : 185
  - 22 : 183
  - 23 : 181
  - 24 : 179
  - 25 : 177
  - 26 : 176
  - 27 : 175
  - 28 : 175
  - 29 : 175
  - 30 : 175
  - 31 : 175
  - 32 : 175
  - 33 : 176
  - 34 : 177
  - 35 : 179
  - 36 : 181
  - 37 : 183
  - 38 : 185
  - 39 : 187
  - 40 : 190
  - 41 : 193
  - 42 : 197
  - 43 : 201
  - 44 : 205
  - 45 : 209
  - 46 : 214
  - 47 : 218
  - 48 : 224
  - 49 : 229
  - 50 : 235
  - 51 : 241
  - 52 : 247
  - 53 : 254
  - 54 : 261
  - 55 : 268
  - 56 : 275
  - 57 : 283
  - 58 : 291
  - 59 : 300


// func signwavePattern(array: [Int], repetitions: Int) -> [Int] {
//     var pattern = [Int]()
//     for _ in 0..<repetitions {
//         pattern += array
//     }
//     return pattern
// }

// let integerArray = [175, 40, 175, 300]
// let repetitions = 2 // Change this value to adjust the number of repetitions

// let signwave = signwavePattern(array: integerArray, repetitions: repetitions)
// print(signwave)
// func generateSineWavePattern(amplitude: Int, frequency: Int, numberOfPoints: Int, minValue: Int, maxValue: Int) -> [Int] {
//     var wavePattern = [Int]()
    
//     for i in 0..<numberOfPoints {
//         let x = Double(i)
//         let y = Int(Double(amplitude) * sin(2.0 * .pi * Double(frequency) * x / Double(numberOfPoints))) + minValue
        
//         wavePattern.append(y)
//     }
    
//     return wavePattern
// }
import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "QuickstartApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

