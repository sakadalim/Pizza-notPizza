//
//  ViewController.swift
//  Pizza notPizza
//
//  Created by Sakada Lim on 7/18/17.
//  Copyright © 2017 Sakada Lim. All rights reserved.
//

import UIKit
import Clarifai
import SwiftyJSON


class ViewController: UIViewController {
    
    let picker = UIImagePickerController()
    
    var app:ClarifaiApp?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        app = ClarifaiApp(apiKey: "bdb50c049f0646eeaf05bf744570a452")
        picker.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "cameraTapped" {
                
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
                
                
                
                
            } else if identifier == "photosTapped" {
                
                picker.allowsEditing = false
                picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                present(picker, animated: true, completion: nil)
                
        
                let resultViewController = segue.destination as! ResultViewController
//                resultViewController.imageView.image =
                
                
            }
            
        }
    }
    
    
    //1 Research programmatic segues 
    //2 When imagedidfinishpickingmedia... , perform segue 
    //3 when performing segue, set destination's image view image to be the selected image
    
    func predictImage(image: UIImage){
        if let app = app {
            app.getModelByID("bd367be194cf45149e75f01d59f77ba7", completion: { (model, error) in
                let caiImage = ClarifaiImage(image: image)!
                model?.predict(on: [caiImage], completion: { (outputs, error) in
                    print("%@", error ?? "no error")
                    guard
                        let caiOutputs = outputs
                        else {
                            print("Predict failed")
                            return
                    }
                    if let caiOutput = caiOutputs.first {
                        for concept in caiOutput.concepts {
                            if concept.conceptName == "pizza" && concept.score >= 0.85 {
                                
                            }
                            else {
        
                            }
                        }
                    }
                })
            })
            
        }

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        dismiss(animated:true, completion: nil)
        
        

        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}
