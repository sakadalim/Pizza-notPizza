//
//  MainView.swift
//  Pizza notPizza
//
//  Created by Sakada Lim on 7/20/17.
//  Copyright © 2017 Sakada Lim. All rights reserved.
//

import AVFoundation
import UIKit

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCapturePhotoOutput?
    var thePreviewLayer: AVCaptureVideoPreviewLayer?
    
    @IBOutlet weak var cameraView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSessionPreset1920x1080
        
        var backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        var error: NSError?
        var input = try! AVCaptureDeviceInput(device: backCamera)
        
        do {
            var input = AVCaptureDeviceInput(device: backCamera)
        }
        
        
    }
}
