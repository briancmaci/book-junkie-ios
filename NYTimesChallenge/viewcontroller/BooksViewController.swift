//
//  BooksViewController.swift
//  NYTimesChallenge
//
//  Created by Brian Maci on 2/17/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit
import SWTableViewCell

class BooksViewController: BookJunkieBaseViewController, UITableViewDelegate, UITableViewDataSource, BooksSubnavigationDelegate, SWTableViewCellDelegate, BaseBookDetailOverlayDelegate {

    @IBOutlet weak var myBooksTable:UITableView!
    @IBOutlet weak var tableTopConstraint:NSLayoutConstraint!
    @IBOutlet weak var tableBottomConstraint:NSLayoutConstraint!
    
    var booksSubnav:BooksSubnavigation!
    
    var isNextUpList : Bool = true
    var nextUpBooksArray : [BookModel] = [BookModel]()
    var finishedBooksArray : [BookModel] = [BookModel]()
    
    var listBookDetailOverlay : ListBookDetailOverlay!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationItem.titleView = nil
        title = K.VCTitle.MyBooks
        
        buildBookArrays()
        initBooksSubnav()
        initTableView()
    }
    
    //re-enabling users to tap table
    override func viewWillAppear(_ animated: Bool) {
        myBooksTable.isUserInteractionEnabled = true
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
    
    func buildBookArrays() {
        
        //clear arrays
        nextUpBooksArray.removeAll()
        finishedBooksArray.removeAll()
        
        for (_ , book) in UserModel.sharedInstance.books {
            
            switch book.saveState {
                case .nextUp:
                    nextUpBooksArray.append(book)
                    nextUpBooksArray = nextUpBooksArray.sorted(by: { $0.bookTitle < $1.bookTitle })
                    
                case .finished:
                    finishedBooksArray.append(book)
                    finishedBooksArray = finishedBooksArray.sorted(by: { $0.bookTitle < $1.bookTitle })
                    
                default:
                    print("Error: We should not get here. Book has no SaveState")
            }
        }
    }
    
    func updateTableListAndData(isNextUp:Bool) {
        isNextUpList = isNextUp
        booksSubnav.setCurrentList(toNextUp: isNextUpList)
        
        myBooksTable.reloadData()
        myBooksTable.sizeToContent(top: tableTopConstraint, bottom: tableBottomConstraint)
    }
    
    ////MARK: - BooksSubnavDelegate Methods
    
    func nextUpTapped() {
        updateTableListAndData(isNextUp: true)
    }
    
    func finishedTapped() {
        updateTableListAndData(isNextUp: false)
    }
    ////MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ReuseID.MyBookCellID, for: indexPath) as! MyBookCell
        
        if isNextUpList == true {
            cell.populate(model: nextUpBooksArray[indexPath.row], index:indexPath.row)
            cell.setRightUtilityButtons(rightButtonsNextUp() as [Any]!, withButtonWidth: K.NumberConstant.SwipeableButtonWidth)
            cell.delegate = self
        }
        
        else {
            cell.populate(model: finishedBooksArray[indexPath.row], index:indexPath.row)
            cell.setRightUtilityButtons(rightButtonsFinished() as [Any]!, withButtonWidth: K.NumberConstant.SwipeableButtonWidth)
            cell.delegate = self
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //blocking users from tapping twice on a single row before the new view appears
        myBooksTable.isUserInteractionEnabled = false
        
        let cell = tableView.cellForRow(at: indexPath) as! MyBookCell
        initListBookDetailOverlay(thisModel: cell.thisModel)
        
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
    
    // SWTableViewCellDelegate Methods
    func rightButtonsNextUp() -> [Any] {
        let rightUtilityButtons = NSMutableArray()
        
        rightUtilityButtons.sw_addUtilityButton(with: K.Color.selectedGreen, icon:UIImage(named:K.Icon.IconAddFinishedOff))
        
        rightUtilityButtons.sw_addUtilityButton(with: K.Color.mainGray, icon:UIImage(named:K.Icon.IconDeleteRow))
        
        return rightUtilityButtons.copy() as! [Any]
    }
    
    func rightButtonsFinished() -> [Any] {
        let rightUtilityButtons = NSMutableArray()
        
        rightUtilityButtons.sw_addUtilityButton(with: K.Color.mainGray, icon:UIImage(named:K.Icon.IconDeleteRow))
        
        return rightUtilityButtons.copy() as! [Any]
    }
    
    func swipeableTableViewCell(_ cell: SWTableViewCell!, didTriggerRightUtilityButtonWith index: Int) {
        
        let thisCell = cell as! MyBookCell
        let cellIndexPath:IndexPath = myBooksTable.indexPath(for: thisCell)!
        
        switch index {
            
        case 0:
            //finished
            if isNextUpList == true {
                thisCell.thisModel.saveState = .finished
                
                //load overlay
                loadRateOverlay(model: thisCell.thisModel)
                
                //push changes to CoreData + UserModel singleton
                updateBookSaveStateWith(model: thisCell.thisModel)
                
                //Update Book Arrays
                let cellIndexPath:IndexPath = myBooksTable.indexPath(for: thisCell)!
                
                nextUpBooksArray.remove(at: cellIndexPath.row)
                myBooksTable.deleteRows(at: [cellIndexPath], with: UITableViewRowAnimation.automatic)
                myBooksTable.sizeToContent(top: tableTopConstraint, bottom: tableBottomConstraint)
                
                buildBookArrays()
            }
            
            else {
               deleteBookFromList(thisUid: thisCell.thisModel.uid, indexPath: cellIndexPath)
            }
            
        case 1:
            //delete
            deleteBookFromList(thisUid: thisCell.thisModel.uid, indexPath: cellIndexPath)
            
        default: break
            
        }
        
        thisCell.hideUtilityButtons(animated: true)
    }
    
    func swipeableTableViewCellShouldHideUtilityButtons(onSwipe cell: SWTableViewCell!) -> Bool {
        return true
    }
    
    func deleteBookFromList(thisUid:String, indexPath:IndexPath) {
        
        //Update arrays
        UserModel.sharedInstance.books[thisUid] = nil
        buildBookArrays()
        
        CoreDataManager.deleteBook(uid: thisUid)
        
        myBooksTable.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        myBooksTable.sizeToContent(top: tableTopConstraint, bottom: tableBottomConstraint)
        
    }
    
    func initListBookDetailOverlay(thisModel:BookModel) {
        
        listBookDetailOverlay = ListBookDetailOverlay.instanceFromNib(name: K.NIBName.ListBookDetailOverlay) as! ListBookDetailOverlay
        
        listBookDetailOverlay.delegate = self
        
        listBookDetailOverlay.populate(model: thisModel)
        
        
        listBookDetailOverlay.frame = listBookDetailOverlay.offFrame
        
        view.addSubview(listBookDetailOverlay)
        
        //animate In
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.listBookDetailOverlay.frame = self.listBookDetailOverlay.onFrame
        }, completion: nil)
    }
    
    ////MARK - BaseBookDetailOverlayDelegate Methods
    internal func addToNextUpTapped(model:BookModel) {
        print("Add this book next: \(model.bookTitle)")
    }
    
    internal func overlayClosed() {
        
        //re-enabling users to tap table
        myBooksTable.isUserInteractionEnabled = true
        
        //animate Out
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.listBookDetailOverlay.frame = self.listBookDetailOverlay.offFrame
        }) { (true) in
            
            //Remove Detail
            self.listBookDetailOverlay.removeFromSuperview()
            self.listBookDetailOverlay = nil
        }
        
    }
    
}
