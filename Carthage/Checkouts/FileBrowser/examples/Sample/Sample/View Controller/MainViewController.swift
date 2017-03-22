//
//  MainViewController.swift
//  Sample
//
//  Created by Mihail Șalari on 9/16/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import UIKit
import FileBrowser

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - FileBrowser
    
    @IBAction func showFileBrowser(sender: AnyObject) {
        let file = FileBrowser()
        present(file, animated: true, completion: nil)
        //self.present(fileBrowser, animated: true, completion: nil)
    }
}

