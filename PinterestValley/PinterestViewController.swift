//
//  PinterestViewController.swift
//  PinterestValley
//
//  Created by Emmanuel on 10/05/2017.
//  Copyright © 2017 Emmanuel. All rights reserved.
//

import UIKit

class PinterestViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    var pinterestData: [Pinterest]?
    
    let requestHandler: RequestHandler = RequestHandler()
    
    //pull to refresh control
    var pullToRefresh: UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register Nib Custom Cell
        self.collectionView.register(UINib(nibName: "PinterestViewCell", bundle: nil), forCellWithReuseIdentifier: "photo")
        

//        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let when = DispatchTime.now() + 2 // wait time in seconds
        
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.pinterestData = PinterestPersistanceData.sharedInstance.getPinterestList()
            self.collectionView.reloadData()
            
        }
        
        
        //pull to refresh action
        self.pullToRefresh = UIRefreshControl()
        //        self.pullToRefresh = UIRefreshControl()
        self.pullToRefresh.attributedTitle = NSAttributedString(string: "Release to Refresh..")
        self.pullToRefresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        // handle ios 10+
        if #available(iOS 10.0, *){
            self.collectionView?.refreshControl = pullToRefresh
        }
        else{
            self.collectionView?.addSubview(pullToRefresh)
        }
        
        // set view background
//        view.backgroundColor = UIColor.darkGray
        
        collectionView!.backgroundColor = UIColor.clear
        collectionView!.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)
        
        self.collectionView?.alwaysBounceVertical = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return PinterestPersistanceData.sharedInstance.getPinterestList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myappscollection", for: indexPath)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath) as! PinterestViewCell
        
//        cell.backgroundColor = UIColor.red
        
        let currentPinterest = PinterestPersistanceData.sharedInstance.getSinglePinterest(index: indexPath.item)
        
        cell.pinterest = currentPinterest
        
        self.requestHandler.getImage(imageURL: currentPinterest.urls.full){
            data, success in
            
            print(success)
        }
        
            print(currentPinterest.urls.full)
      
        cell.coverImage.image = UIImage(named: "haha")
        
        return cell
    }
    
    
    //MARK: PullToRefresh action call
    func refreshData(){
        
        print("pulled refreshing...")
        
        collectionView?.reloadData()
        
        self.pullToRefresh.endRefreshing()
        
        
        //        self.pullToRefresh.endRefreshing()
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}
