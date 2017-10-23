//
//  CollectionViewCell.swift
//  UICollectionView
//
//  Created by Brian Coleman on 2014-09-04.
//  Copyright (c) 2014 Brian Coleman. All rights reserved.
//

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
