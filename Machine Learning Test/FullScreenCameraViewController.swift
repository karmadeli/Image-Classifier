//
//  FullScreenCameraViewController.swift
//  Machine Learning Test
//
//  Created by Chad Karma-Deli on 12/3/17.
//  Copyright © 2017 KarmaDeli Works. All rights reserved.
//

import UIKit

class FullScreenCameraViewController: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
        FullSreenCamera.image = image
        }
    }

    @IBOutlet weak var FullSreenCamera: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
         self.sourceType = .camera
 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }

    

    
    

}
