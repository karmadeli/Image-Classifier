//
//  ViewController.swift
//  Machine Learning Test
//
//  Created by Chad Karma-Deli on 11/11/17.
//  Copyright © 2017 KarmaDeli Works. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    let imagePicker = UIImagePickerController()
   
    @IBOutlet weak var confidence: UILabel!
    
    @IBOutlet weak var AIReturn: UILabel!
    
    
    //tells the delegate, ie our viewcontroller class, that user has picked an image.
    //The info parameter contains the image that the user picked.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let imageUserPicked = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageVIew.image = imageUserPicked
            
            guard let ciimage = CIImage(image: imageUserPicked) else{fatalError("ERROR could convert to cimage")}
            
            detect(image: ciimage)
        }
        
        
        imagePicker.dismiss(animated: true, completion: nil)

        
    }
    
    
    @IBOutlet weak var instructions: UILabel!
    func detect(image: CIImage){
       
        do{
            let model = try VNCoreMLModel(for: Inceptionv3().model)
            let request = VNCoreMLRequest(model: model) { (request, error) in
//VNClassificationObservation: hold classifaction observations and possible matches
                guard let results = request.results as? [VNClassificationObservation] else{fatalError("model failled to process image")}
                print("🤡 \(results)")
                
                if let firstResult = results.first{
                    print("\(String(describing: results.first?.confidence))")
                    print("🍟\(firstResult.identifier)🍟")
                    
                    let con = results.first!.confidence*100
                    let bestResults = firstResult.identifier
                 
                 var i = bestResults.split(separator: ",")
                    
                    self.confidence.text = "\(Int(con))%"
                    
                    if i.count > 1{
                        self.AIReturn.text = "\(String(i[0].capitalized)) or maybe a(n)\(String(i[1]))."}
                    else{self.AIReturn.text = "\(String(i[0].capitalized))"}
                    
                    self.instructions.isHidden = true
                    
                }
                
            }
            
            let handler = VNImageRequestHandler(ciImage: image)
            do{
                try handler.perform([request])
                print("📟Request performed")}
                
            catch{print(error.localizedDescription)}
        }
       
        catch let error{
            print (error)
        }
        
        
        
        
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBOutlet weak var imageVIew: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        confidence.text = ""
        AIReturn.text = ""
        
       
        //source type could also be .photolibrary
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
    
    }
    
}
