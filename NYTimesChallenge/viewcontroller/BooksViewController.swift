//
//  BooksViewController.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/17/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit

class BooksViewController: BookJunkieBaseViewController, UITableViewDelegate, UITableViewDataSource, BooksSubnavigationDelegate {

    @IBOutlet weak var myBooksTable:UITableView!
    @IBOutlet weak var tableBottomConstraint:NSLayoutConstraint!
    
    var booksSubnav:BooksSubnavigation!
    
    var isNextUpList : Bool = true
    var nextUpBooksArray : [BookModel] = [BookModel]()
    var finishedBooksArray : [BookModel] = [BookModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationItem.titleView = nil
        title = "MY BOOKS"
        
        initBooksSubnav()
        initTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initBooksSubnav() {
        
        booksSubnav = BooksSubnavigation(frame: CGRect(x:0, y:0, width:K.Screen.Width, height:K.NumberConstant.MyBooksSubNavigationHeight))
        
        booksSubnav.initSubnav()
        booksSubnav.setCurrentList(toNextUp: isNextUpList)
        booksSubnav.delegate = self
        
        view.addSubview(booksSubnav)
    }
    
    func initTableView() {
        myBooksTable.delegate = self
        myBooksTable.dataSource = self
        
        //register UITableViewCells
        myBooksTable.register(UINib(nibName: K.NIBName.MyBookCell, bundle: nil), forCellReuseIdentifier: K.ReuseID.MyBookCellID)
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    ////MARK: - BooksSubnavDelegate Methods
    
    func nextUpTapped() {
        isNextUpList = true
        booksSubnav.setCurrentList(toNextUp: isNextUpList)
    }
    
    func finishedTapped() {
        isNextUpList = false
        booksSubnav.setCurrentList(toNextUp: isNextUpList)
    }
    ////MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ReuseID.MyBookCellID, for: indexPath) as! MyBookCell
        
        if isNextUpList == true {
            cell.populate(model: nextUpBooksArray[indexPath.row], index:indexPath.row)
        }
        
        else {
            cell.populate(model: finishedBooksArray[indexPath.row], index:indexPath.row)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //select - toggle listIsSelected
        
        //let cell = tableView.cellForRow(at: indexPath) as! MyBookCell
        
//        UserModel.sharedInstance.lists[cell.thisIndex].listIsSelected = !UserModel.sharedInstance.lists[cell.thisIndex].listIsSelected
//        
//        cell.updateRowWith(model: UserModel.sharedInstance.lists[cell.thisIndex])
//        
//        //Push to CoreData
//        CoreDataManager.updateBestSellerListSelection(listNameEncoded: cell.thisModel.listNameEncoded, isSelected: cell.thisModel.listIsSelected)
        
        //deselect
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return K.NumberConstant.MyListsRowHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isNextUpList == true {
            return nextUpBooksArray.count
        }
        
        else {
            return finishedBooksArray.count
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
