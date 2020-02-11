//
//  ViewController.swift
//  Project Setup
//
//  Created by Admin on 08/01/19.
//  Copyright © 2019 VISHAL. All rights reserved.
//

import UIKit
import Reachability
class ViewController: UIViewController, UtilityDelegate {

    var utility: Utility = Utility()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.utility.delegate = self
    }
    
    
    // MARK: - Api Call Completion Delegate
    func apiCallCompleted(_ success: Bool, result: [String : Any]?, error: String, apiType: APIType) {
        VLoader.instance.dismissProgress()
        if(success) {
            switch apiType {
            case .GetAlbum:
                
                brea
                    default:
                        print("")
            default:
                break
            }
        }
        else {
            
        }
    }
}

