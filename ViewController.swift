//
//  ViewController.swift
//  Reciplease
//
//  Created by Manon Russo on 24/05/2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        AF.request("https://api.edamam.com/search?q=chicken,ham,curry&app_key=b5144453065bd0a94728a7da37aa3548&app_id=d698f1a4&ingredient=food&food=label").response { response in
            debugPrint(response)
        }
    }

}

