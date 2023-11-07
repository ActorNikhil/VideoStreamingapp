//
//  CollectionViewCell.swift
//  UICollectionView
//
//  Created by Brian Coleman on 2014-09-04.
//  Copyright (c) 2014 Brian Coleman. All rights import SwiftUI
import SwiftUI

struct Snowflake: View {
    @State private var snowflakeOffset: CGPoint = CGPoint(x: 0, y: 0)

    var body: some View {
        Image(systemName: "snow")
            .font(.title)
            .offset(x: snowflakeOffset.x, y: snowflakeOffset.y)
            .onAppear {
                withAnimation(Animation.linear(duration: 5).repeatForever(autoreverses: false)) {
                    self.snowflakeOffset = CGPoint(x: Double.random(in: 0...UIScreen.main.bounds.width), y: Double(UIScreen.main.bounds.height))
                }
            }
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)

            ForEach(0..<10) { _ in
                Snowflake()
            }
        }
    }
}

@main
struct SnowflakeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
struct Snowflake: View {
    @State private var snowflakeOffset: CGFloat = 0
    
    var body: some View {
        Image(systemName: "snow")
            .font(.title)
            .offset(y: snowflakeOffset)
            .onAppear {
                withAnimation(Animation.linear(duration: 5).repeatForever(autoreverses: false)) {
                    self.snowflakeOffset = UIScreen.main.bounds.height
                }
            }
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            
            ForEach(0..<10) { _ in
                Snowflake()
            }
        }
    }
}

@main
struct SnowflakeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

import UIKit

class CollectionViewCell: UICollectionViewCell {

    var textLabel: UILabel!
    var webView: UIWebView!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        webView = UIWebView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        webView.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(webView)
        
        let textFrame = CGRect(x: 0, y: 32, width: frame.size.width, height: frame.size.height/3)
        textLabel = UILabel(frame: textFrame)
        textLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        textLabel.textAlignment = .center
        contentView.addSubview(textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        
    }
}
