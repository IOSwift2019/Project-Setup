//
//  Utility.swift
//  Project Setup
//
//  Created by Admin on 08/01/19.
//  Copyright © 2019 VISHAL. All rights reserved.
//

import UIKit
import Foundation
import SVProgressHUD
import Reachability
import Alamofire
@objc protocol  UtilityDelegate {
    @objc optional func apiCallCompleted(_ success: Bool, result: NSDictionary?, error: String, apiType: APIType)
}
class Utility {
    var window: UIWindow?
    var delegate: UtilityDelegate?
    
    class func showAlert(_ title: String?, message: String?, viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action: UIAlertAction) in
        }))
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    class func showProgress(_ message: String) {
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        if(message == "") {
            SVProgressHUD.show()
        }
        else {
            SVProgressHUD.show(withStatus: message)
        }
    }
    
    class func dismissProgress() {
        SVProgressHUD.dismiss()
    }
    
    class func checkInternet() -> Bool {
        let networkReachability: Reachability = Reachability.forInternetConnection();
        let networkStatus : NetworkStatus = networkReachability.currentReachabilityStatus();
        if (networkStatus.rawValue == 0) {
            return false;
        } else {
            return true;
        }
    }
    
    func addItem(apiType: APIType) {
        if Utility.checkInternet(){
            self.delegate?.apiCallCompleted?(true, result: [:], error: String(), apiType: apiType)
            self.delegate?.apiCallCompleted?(false, result: [:], error: String(), apiType: apiType)
        }
        else{
            Utility.showAlert("Connection Error!", message: "Please check internet connection and retry.", viewController: (self.window?.rootViewController)!)
        }
    }
    
     func getSticker(url:String, apiType: APIType) {
        if Utility.checkInternet(){
            Alamofire.request(url, method: .get).responseJSON { (response) in
                switch response.result {
                case .success:
                    let dic:[String:Any] = response.value as! [String : Any]
                    if dic["stat"] as! String == "ok" {
                        let photoset = dic["photoset"] as! [String:Any]
                        self.delegate?.apiCallCompleted?(true, result: photoset, error: String(), apiType: apiType)
                    } else {
                        self.delegate?.apiCallCompleted?(false, result: [:], error: (dic["message"] as? String)! , apiType: apiType)
                    }
                    break
                case .failure(let error):
                    self.delegate?.apiCallCompleted?(false, result: [:], error: error.localizedDescription , apiType: apiType)
                }
            }
        }
        else{
            let alert = UIAlertView()
            alert.title = "Connection Error!"
            alert.message = "Please check internet connection and retry."
            alert.addButton(withTitle: "OK")
            alert.show()
        }
    }
    
    
}
