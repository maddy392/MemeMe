//
//  ViewController.swift
//  MemeMe1.0
//
//  Created by MadhuBabu Adiki on 4/23/24.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,
UITextFieldDelegate {
    
    // MARK: All outlets
    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topCommentTextField: UITextField!
    @IBOutlet weak var bottomCommentTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    
    
    // MARK: Meme attributes
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1),
        NSAttributedString.Key.strokeWidth: -4,
        NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
    ]
    
    // MARK: set delegate and textfield properties
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.topCommentTextField.defaultTextAttributes = memeTextAttributes
        self.topCommentTextField.textAlignment = NSTextAlignment(.center)
        self.topCommentTextField.borderStyle = .none
        
        self.bottomCommentTextField.defaultTextAttributes = memeTextAttributes
        self.bottomCommentTextField.textAlignment = NSTextAlignment(.center)
        self.bottomCommentTextField.borderStyle = .none

        self.topCommentTextField.delegate = self
        self.bottomCommentTextField.delegate = self
        
    }
    
    // MARK: disable/hide share button
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        if displayImage.image != nil {
            shareButton.isEnabled = true
        } else {
            shareButton.isEnabled = false
        }
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        //        print(view.frame.origin.y)
        if bottomCommentTextField.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0.0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let currentString = textField.text! as NSString
        print("Current String \(currentString)")
        let stringNoDefault = currentString.replacingOccurrences(of: "TOP", with: "").replacingOccurrences(of: "BOTTOM", with: "")
        
        textField.text = stringNoDefault
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func pickAnImage(_ sender: Any) {
        
        let sender = sender as! UIBarButtonItem
        let sender_title = sender.title!
        
        let picker_controller = UIImagePickerController()
        picker_controller.delegate = self
        
        if sender_title == "Photo Library" {
            picker_controller.sourceType = .photoLibrary
        }
        else {
            picker_controller.sourceType = .camera
        }
        
        self.present(picker_controller, animated: true,
        completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            displayImage.image = image
            self.topCommentTextField.text = "TOP"
            self.bottomCommentTextField.text = "BOTTOM"

        }

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
        shareButton.isEnabled = true
    }
    
    
    struct Meme {
        var topText: String?
        var bottomText: String?
        var originalImage: UIImage?
        var memedImage: UIImage
    }
    
    func generateMemedImage() -> UIImage {
        
        self.toolbar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.toolbar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false

        
        return memedImage
    }
    
    func save(_ memedImage: UIImage) {
        
        let originalImage = displayImage.image
        let topText = topCommentTextField.text!
        let bottomText = bottomCommentTextField.text!

        let _ = Meme(topText: topText, bottomText: bottomText, originalImage: originalImage,memedImage: memedImage)
        
    }
    
    @IBAction func shareImage(_ sender: Any) {
        
        let memedImage = generateMemedImage()
        
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        self.present(controller, animated: true, completion: nil)
        
        controller.completionWithItemsHandler = { (_, completed, _, _) in
                
            if (completed) {
                self.save(memedImage)
            }
        }
        
    }
    
}

