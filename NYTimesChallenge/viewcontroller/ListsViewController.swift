//
//  ListsViewController.swift
//  NYTimesChallenge
//
//  Created by Chelsea Power on 2/17/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

class ListsViewController: BookJunkieBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.titleView = nil
        title = "MY LISTS"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
