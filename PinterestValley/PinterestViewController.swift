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
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    
    let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
    
    var pinterestData: [Pinterest]?
    
    let requestHandler: RequestHandler = RequestHandler()
    
    //pull to refresh control
    var pullToRefresh: UIRefreshControl!
    
    
    // view loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register Nib Custom Cell
        self.collectionView.register(UINib(nibName: "PinterestViewCell", bundle: nil), forCellWithReuseIdentifier: "photo")
        
        if PinterestPersistanceData.sharedInstance.getPinterestList().count != 0 {
            print("reloading data . . ")
            self.collectionView.reloadData()
        }
//        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 6) {
            print("6 seconds later")
            //            self.collectionView.reloadData()
            let pinterestCount = PinterestPersistanceData.sharedInstance.getPinterestList().count
                
            if pinterestCount > 0 {
                print("reloading data . . ")
                self.collectionView.reloadData()
            }
            
        }
        
    }
    
    // view will appear
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.pinterestData = PinterestPersistanceData.sharedInstance.getPinterestList()
            
            
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
        view.backgroundColor = UIColor(patternImage: UIImage(named: "haha")!)
        
        
        collectionView!.backgroundColor = UIColor.clear
//        collectionView!.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)
        
        self.collectionView?.alwaysBounceVertical = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view appeared")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // number of items in collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PinterestPersistanceData.sharedInstance.getPinterestList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath) as! PinterestViewCell
        
        let currentPinterest = PinterestPersistanceData.sharedInstance.getSinglePinterest(index: indexPath.item)
        
        let profileImageURL = URL(string: currentPinterest.user.profileImage.large)
        let coverImageURL = URL(string: currentPinterest.urls.small)
        
        
        // load cache profile image
        if (ImageCache.sharedCache.object(forKey: profileImageURL! as AnyObject) != nil) {
            let currentProfileImage = ImageCache.sharedCache.object(forKey: profileImageURL! as AnyObject) as! UIImage
            
            cell.avatarImage.image = currentProfileImage
        }
        
        // load cache cover image
        if (ImageCache.sharedCache.object(forKey: coverImageURL! as AnyObject) != nil) {
            let currentCoverImage = ImageCache.sharedCache.object(forKey: coverImageURL! as AnyObject) as! UIImage
            
            cell.coverImage.image = currentCoverImage
        }
        
        cell.pinterest = currentPinterest
        
        cell.avatarImage.layer.cornerRadius = cell.avatarImage.frame.size.width / 4
        cell.coverImage.layer.cornerRadius = 15.0
        
        cell.cellUIView.layer.cornerRadius = 15.0

        return cell
    }
    
    
    // pinterest item selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.item) selected")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.6, animations: {
            cell.alpha = 1
        })
    }
    
    
    //MARK: PullToRefresh action call
    func refreshData(){
        
        print("pulled refreshing...")
        
        DispatchQueue.main.async {
            self.pinterestData = PinterestPersistanceData.sharedInstance.getPinterestList()
            
        }

        collectionView?.reloadData()
        
        self.pullToRefresh.endRefreshing()
        
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
