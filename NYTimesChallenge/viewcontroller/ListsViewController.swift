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
    @IBOutlet weak var tableBottomConstraint:NSLayoutConstraint!
    
    //pulling just selected lists from all lists 
    var myListsArray:[BestSellerListModel] = [BestSellerListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.titleView = nil
        title = "MY LISTS"
        
        initTableView()
        
        //load data
        loadBestsellerLists()
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
    
    func loadBestsellerLists() {
        
        UserModel.sharedInstance.lists = CoreDataManager.retrieveBestSellerLists()
        
        if UserModel.sharedInstance.lists.isEmpty == true {
            APICallManager.getBestSellerLists { (responseObject, error) in
                
                if responseObject != nil {
                    UserModel.sharedInstance.lists = DataParseManager.parseDataIntoLists(data: responseObject)
                    self.buildMyListsArray()
                    
                    for list in UserModel.sharedInstance.lists {
                        CoreDataManager.saveBestSellerList(thisList: list)
                    }
                }
            }
        }
        
        else {
            buildMyListsArray()
        }
    }
    
    func buildMyListsArray () {
        
        myListsArray = UserModel.sharedInstance.lists.filter {
            $0.listIsSelected == true
        }
        
        myListsTable.reloadData()
        myListsTable.sizeToContent(bottom: tableBottomConstraint)
    }
    
    ////MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.ReuseID.MyListsCellID, for: indexPath) as! MyListsCell
        
            cell.populate(model: myListsArray[indexPath.row], index:indexPath.row)
            cell.setFor(myLists: true)
            return cell
            
        }
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.ReuseID.MyListsFooterCellID, for: indexPath) as! MyListsFooterCell
            
            cell.updateAddMore(num: myListsArray.count) 
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            //select - load list
        }
        
        else {
            //go to all lists
            let newVC = AppUtilities.getViewControllerFromStoryboard(id: K.Storyboard.ID.AllLists) as! AllListsViewController
            navigationController?.pushViewController(newVC, animated:true)
        }
        
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
            return myListsArray.count
        }
        
        else {
            return 1
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

}
