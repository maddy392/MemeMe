//
//  MemeCollectionViewController.swift
//  MemeMe1.0
//
//  Created by MadhuBabu Adiki on 5/9/24.
//

import UIKit
import Foundation

class MemeCollectionViewController: UICollectionViewController {
    
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView!.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        if memes.isEmpty == false {
            return memes.count
//        }
//        else {
//            return 4 }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        
//        if memes.isEmpty == false {
            let meme = memes[(indexPath as NSIndexPath).row]
            cell.memeImage?.image = meme.memedImage
//        }
        
//        else {
            
//            cell.memeImage?.image = UIImage(named: "Silva") }
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let memeDetailViewController = storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        let meme = memes[(indexPath as NSIndexPath).row]
        
        memeDetailViewController.meme = meme
        
        navigationController!.pushViewController(memeDetailViewController, animated: true)
//        self.present(memeDetailViewController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 3
        let width = (view.frame.size.width - (2 * space)) / 4.0
        let height = (view.frame.size.height - (2 * space)) / 4.0
        
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSize(width: width, height: height)
        collectionView.collectionViewLayout = flowLayout
    }
    
}
