//
//  ListsViewController.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/17/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

class ListsViewController: BookJunkieBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myListsTable:UITableView!
    
    let listsArray = Array(UserModel.sharedInstance.lists)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.titleView = nil
        title = "MY LISTS"
        
        initTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initTableView() {
        myListsTable.delegate = self
        myListsTable.dataSource = self
        
        //register UITableViewCells
        myListsTable.register(UINib(nibName: K.NIBName.MyListsCell, bundle: nil), forCellReuseIdentifier: K.ReuseID.MyListsCellID)
        
        myListsTable.register(UINib(nibName: K.NIBName.MyListsFooterCell, bundle: nil), forCellReuseIdentifier: K.ReuseID.MyListsFooterCellID)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    ////MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.ReuseID.MyListsCellID, for: indexPath) as! MyListsCell
        
            cell.populate(model: listsArray[indexPath.row], index:indexPath.row)

            return cell
            
        }
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.ReuseID.MyListsFooterCellID, for: indexPath) as! MyListsFooterCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //select - load list
        
        //deselect
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return K.NumberConstant.MyListsRowHeight
        }
        
        else {
            return K.NumberConstant.MyListsFooterHeight
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //This will be based on ListModel count where selected = true
        
        if section == 0 {
            return listsArray.count
        }
        
        else {
            return 1
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

}
