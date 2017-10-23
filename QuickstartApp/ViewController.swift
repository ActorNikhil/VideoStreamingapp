//
//  ViewController.swift
//  QuickstartApp
//
//  Created by Nikhil Challagulla on 10/20/17.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView?

    var arrayofVideos =   ["https://www.youtube.com/embed/uPCMjEsTHag"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let serviceReq =  ServiceRequest()
        serviceReq.requestForVideos(value: "Apple")
        

        
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: 160, height: 160)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView!.dataSource = self
        collectionView!.delegate   = self
        collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView!.backgroundColor = UIColor.red
        self.view.addSubview(collectionView!)
        

        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 20
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = UIColor.black
        cell.textLabel?.text = "\(indexPath.section):\(indexPath.row)"
        DispatchQueue.main.async(execute: { () -> Void in
            let urlString = "https://www.youtube.com/embed/uPCMjEsTHag"
            cell.webView?.loadHTMLString("<iframe width=\"160\" height=\"160\" src=\"\(urlString)\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
            
        })
        return cell
    }
    
    

}

