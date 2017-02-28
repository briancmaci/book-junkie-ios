//
//  ListDetailViewController.swift
//  NYTimesChallenge
//
//  Created by Chelsea Power on 2/20/17.
//  Copyright © 2017 Brian Maci. All rights reserved.
//

import UIKit
import SWTableViewCell
import SafariServices

class ListDetailViewController: BookJunkieBaseViewController, UITableViewDelegate, UITableViewDataSource, SWTableViewCellDelegate, BaseBookDetailOverlayDelegate, SFSafariViewControllerDelegate {

    @IBOutlet weak var listDetailTable:UITableView!
    @IBOutlet weak var tableTopConstraint:NSLayoutConstraint!
    @IBOutlet weak var tableBottomConstraint:NSLayoutConstraint!
    
    var viewTitle : String = ""
    var listToSearch : String = ""
    
    var bookArray : [BookModel] = [BookModel]()
    var listBookDetailOverlay : ListBookDetailOverlay!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationItem.titleView = nil
        title = viewTitle
        adjustTitleTextResize()
        initTableView()
        
        loadListBooks()
        
    }
    
    //re-enabling users to tap table
    override func viewWillAppear(_ animated: Bool) {
        listDetailTable.isUserInteractionEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initTableView() {
        listDetailTable.delegate = self
        listDetailTable.dataSource = self
        
        //register UITableViewCells
        listDetailTable.register(UINib(nibName: K.NIBName.MyListDetailsCell, bundle: nil), forCellReuseIdentifier: K.ReuseID.MyListDetailsCellID)
    }
    
    func adjustTitleTextResize() {
        let tLabel = UILabel(frame: CGRect(x:0, y:0, width:K.Screen.Width, height:22))
        tLabel.text = self.title
        tLabel.textAlignment = .center
        tLabel.textColor = UIColor.white
        tLabel.font = UIFont(name: "WhitneyCondensed-Medium", size: 22.0)
        tLabel.backgroundColor = UIColor.clear
        tLabel.adjustsFontSizeToFitWidth = true
        self.navigationItem.titleView = tLabel
    }
    
    func loadListBooks() {
        
        APICallManager.getListDetailByName(which: listToSearch) { (responseObject, error) in
            if responseObject != nil {
                self.bookArray = DataParseManager.parseDataIntoListBooks(data: responseObject)
                
                //Now we have to update all markers and SaveStates
                self.loadSaveStatesFromUserModel()
                
                self.listDetailTable.reloadData()
                self.listDetailTable.sizeToContent(top: self.tableTopConstraint, bottom: self.tableBottomConstraint)
            }
        }
    }
    
    func loadSaveStatesFromUserModel() {
        
        for (index, _) in bookArray.enumerated() {
            let thisUID = bookArray[index].uid
            if UserModel.sharedInstance.books[thisUID] != nil {
                bookArray[index].saveState = (UserModel.sharedInstance.books[thisUID]?.saveState)!
            }
        }
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
    
    ////MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ReuseID.MyListDetailsCellID, for: indexPath) as! MyListDetailsCell
        
        cell.populate(model: bookArray[indexPath.row], index:indexPath.row)
        cell.setRightUtilityButtons(rightButtons() as [Any]!, withButtonWidth: K.NumberConstant.SwipeableButtonWidth)
        cell.updateSaveState()
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //select - load book detail page
        
        //blocking users from tapping twice on a single row before the new view appears
        listDetailTable.isUserInteractionEnabled = false
        
        let cell = tableView.cellForRow(at: indexPath) as! MyListDetailsCell
        initListBookDetailOverlay(thisModel: cell.thisModel)
        
        //deselect
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return K.NumberConstant.MyListsRowHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func rightButtons() -> [Any] {
        let rightUtilityButtons = NSMutableArray()
        
        rightUtilityButtons.sw_addUtilityButton(with: K.Color.selectedYellow, icon:UIImage(named:K.Icon.IconAddNextUpOff))
        
        rightUtilityButtons.sw_addUtilityButton(with: K.Color.selectedGreen, icon:UIImage(named:K.Icon.IconAddFinishedOff))
        
        return rightUtilityButtons.copy() as! [Any]
    }
    
    func swipeableTableViewCell(_ cell: SWTableViewCell!, didTriggerRightUtilityButtonWith index: Int) {
        
        let thisCell = cell as! MyListDetailsCell
        switch index {
            
        case 0:
            //nextUp
            thisCell.thisModel.saveState = .nextUp
            
        case 1:
            //finished
            thisCell.thisModel.saveState = .finished
            
            //load overlay
            loadRateOverlay(model: thisCell.thisModel)
            
        default:
            thisCell.thisModel.saveState = .none
        }
        
        thisCell.updateSaveState()
        thisCell.hideUtilityButtons(animated: true)
        
       updateBookSaveStateWith(model: thisCell.thisModel)
    }
    
    func swipeableTableViewCellShouldHideUtilityButtons(onSwipe cell: SWTableViewCell!) -> Bool {
        return true
    }
    
    ////MARK - BaseBookDetailOverlayDelegate Methods
    internal func addToNextUpTapped(model:BookModel) {
        print("Add this book next: \(model.bookTitle)")
    }
    
    internal func overlayClosed() {
        
        //re-enabling users to tap table
        listDetailTable.isUserInteractionEnabled = true
        
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
