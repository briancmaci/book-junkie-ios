//
//  AllListsViewController.swift
//  NYTimesChallenge
//
//  Created by Chelsea Power on 2/20/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

class AllListsViewController: BookJunkieBaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var allListsTable:UITableView!
    @IBOutlet weak var tableBottomConstraint:NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationItem.titleView = nil
        title = K.VCTitle.AllLists
        
        initTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initTableView() {
        allListsTable.delegate = self
        allListsTable.dataSource = self
        
        //register UITableViewCells
        allListsTable.register(UINib(nibName: K.NIBName.MyListsCell, bundle: nil), forCellReuseIdentifier: K.ReuseID.MyListsCellID)
        
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
        
       let cell = tableView.dequeueReusableCell(withIdentifier: K.ReuseID.MyListsCellID, for: indexPath) as! MyListsCell
        
        cell.setFor(myLists: false)
        cell.populate(model: UserModel.sharedInstance.lists[indexPath.row], index:indexPath.row)
        cell.updateRowWith(model: cell.thisModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //select - toggle listIsSelected
        
        let cell = tableView.cellForRow(at: indexPath) as! MyListsCell
        
        UserModel.sharedInstance.lists[cell.thisIndex].listIsSelected = !UserModel.sharedInstance.lists[cell.thisIndex].listIsSelected
        
        cell.updateRowWith(model: UserModel.sharedInstance.lists[cell.thisIndex])
        
        //Push to CoreData
        CoreDataManager.updateBestSellerListSelection(listNameEncoded: cell.thisModel.listNameEncoded, isSelected: cell.thisModel.listIsSelected)
        
        //deselect
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return K.NumberConstant.MyListsRowHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserModel.sharedInstance.lists.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
