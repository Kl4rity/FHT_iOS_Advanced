//
//  ViewController.swift
//  sharingApplication
//
//  Created by Clemens Stift on 03.12.18.
//  Copyright © 2018 Clemens Stift. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var inputField: UITextField!
    
    let imagePickerView: UIImagePickerController = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imagePickerView.sourceType = .photoLibrary
        imagePickerView.delegate = self
    }

    @IBAction func shareText(_ sender: Any) {
        let textItem = inputField.text
        let items = [textItem]
        let ac = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        present(ac, animated:true)
    }
    
    @IBAction func sharePicture(_ sender: Any) {
        
        self.present(imagePickerView, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePickerView.dismiss(animated:true, completion: nil)
        let items = [info[UIImagePickerController.InfoKey.originalImage] as? UIImage]
        
        let ac = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        present(ac, animated:true)
    }

    
}

