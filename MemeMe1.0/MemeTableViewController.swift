//
//  MemeTableViewController.swift
//  MemeMe1.0
//
//  Created by MadhuBabu Adiki on 5/11/24.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView!.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
        
//        if memes.isEmpty == false {
//            return memes.count
//        }
//        else {
//            return 4
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell") as! MemeTableViewCell
        
//        if memes.isEmpty == false {
            let meme = memes[(indexPath as NSIndexPath).row]
            
            cell.memeImage?.image = meme.memedImage
            cell.memeText?.text = meme.topText! + " " + meme.bottomText!
//        }
//        else {
//            cell.memeText?.text = "testing"
//            cell.memeImage?.image = UIImage(named: "Silva")
//        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 6.5 }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeDetailViewController = storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        let meme = memes[(indexPath as NSIndexPath).row]
        
        memeDetailViewController.meme = meme
        
        navigationController!.pushViewController(memeDetailViewController, animated: true)
//        self.present(memeDetailViewController, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
