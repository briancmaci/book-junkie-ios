//
//  AwardsViewController.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/17/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

class AwardsViewController: BookJunkieBaseViewController {
    
    @IBOutlet weak var rankHeader : UILabel!
    @IBOutlet weak var rankLabel : UILabel!
    @IBOutlet weak var finishedNumberLabel : UILabel!
    @IBOutlet weak var finishedAwardLabel : UILabel!
    @IBOutlet weak var ratingsNumberLabel : UILabel!
    @IBOutlet weak var ratingsAwardLabel : UILabel!
    
    var totalBooks:Int = 0
    var totalRatings:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.titleView = nil
        title = K.VCTitle.MyAwards
        
        retrieveTotals()
        initAwardsCopy()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retrieveTotals() {
        totalBooks = UserModel.getReadBooksTotal()
        totalRatings = UserModel.getRatingsTotal()
    }
    
    func initAwardsCopy() {
        rankHeader.text = K.StringFormat.RankHeader
        rankLabel.text = UserModel.getFinishedRank()
        finishedNumberLabel.text = String(totalBooks)
        finishedAwardLabel.text = K.StringFormat.FinishedFooter
        ratingsNumberLabel.text = String(totalRatings)
        ratingsAwardLabel.text = K.StringFormat.RatingsFooter
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
