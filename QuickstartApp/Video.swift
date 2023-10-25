//
//  Video.swift
//  QuickstartApp
//
//  Created by Nikhil Challagulla on 10/20/17.
//
import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @State private var selectedTime: Date?
    
    let data: [DataPoint] = [
        DataPoint(time: Date().addingTimeInterval(-3600), value: 20),
        DataPoint(time: Date().addingTimeInterval(-2700), value: 25),
        DataPoint(time: Date().addingTimeInterval(-1800), value: 40),
        DataPoint(time: Date().addingTimeInterval(-900), value: 15),
        DataPoint(time: Date(), value: 35)
    ]
    
    var body: some View {
        VStack {
            LineChart(data: data, title: "Hourly Data", legend: "Values", valueSpecifier: "%.0f", legendSpecifier: "%.0f")
                .touchOverlay(chartData: data, specifier: "HH:mm")
                .yAxisGrid(yInterval: 50.0)
                .xAxisTime(tickCount: 5)
                .onTouchGesture { touch in
                    if let dataPoint = touch.chartPoint {
                        selectedTime = dataPoint.x as? Date
                    }
                }
            
            if let selectedTime = selectedTime {
                Text("Selected Time: \(selectedTime, style: .time)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DataPoint: ChartData {
    var time: Date
    var value: Double
}
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
