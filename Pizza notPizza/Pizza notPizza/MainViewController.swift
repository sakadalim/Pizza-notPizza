//
//  MainView.swift
//  Pizza notPizza
//
//  Created by Sakada Lim on 7/20/17.
//  Copyright © 2017 Sakada Lim. All rights reserved.
//

import UIKit
import SwiftyCam

class MainViewController: SwiftyCamViewController , SwiftyCamViewControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraDelegate = self
    }
}
