//
//  MemeDetailViewController.swift
//  MemeMe1.0
//
//  Created by MadhuBabu Adiki on 5/14/24.
//

import UIKit

class MemeDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.memeImage!.image = meme.memedImage
        self.navigationItem.title = "Meme Detail"

        // Do any additional setup after loading the view.
    }
    
    var meme: Meme!
    @IBOutlet weak var memeImage: UIImageView!
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
