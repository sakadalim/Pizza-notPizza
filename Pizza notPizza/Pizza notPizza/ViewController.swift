//
//  ViewController.swift
//  Pizza notPizza
//
//  Created by Sakada Lim on 7/18/17.
//  Copyright © 2017 Sakada Lim. All rights reserved.
//

import UIKit
import Clarifai



class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    let picker = UIImagePickerController()

    var app:ClarifaiApp?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        app = ClarifaiApp(apiKey: "bdb50c049f0646eeaf05bf744570a452")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func photosTapped(_ sender: Any) {
        picker.allowsEditing = false;
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        picker.delegate = self;
        present(picker, animated: true, completion: nil)

    }
    @IBAction func cameraTapped(_ sender: Any) {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            present(picker, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func recognizeImage(image: UIImage) {
        
        // Check that the application was initialized correctly.
        if let app = app {
            
            // Fetch Clarifai's general model.
//            app.getModelByID("bd367be194cf45149e75f01d59f77ba7", completion: { (model, error) in
                app.getModelByID("aaa03c23b3724a16a56b629203edc62c", completion: { (model, error) in

                // Create a Clarifai image from a uiimage.
                let caiImage = ClarifaiImage(image: image)!
                
                // Use Clarifai's general model to pedict tags for the given image.
                model?.predict(on: [caiImage], completion: { (outputs, error) in
                    print("%@", error ?? "no error")
                    guard
                        let caiOuputs = outputs
                        else {
                            print("Predict failed")
                            return
                    }
                    
                    if let caiOutput = caiOuputs.first {
                        var result = false
                        
                        for concept in caiOutput.concepts{
                            if concept.conceptName == "pizza" && concept.score >= 0.9 {
                                result = true
                            }
                        }
                        DispatchQueue.main.async {
                            if result == true {
                                self.resultLabel.text = "PIZZAAAAAAA"
                            } else {
                                self.resultLabel.text = "Not a pizza."
                            }
                        }
                        
                        
                    }
                    
                })
            })
        }
    }


}

    
    
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imageView.image = chosenImage
        recognizeImage(image: chosenImage)
        resultLabel.text = "Analizing..."
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

