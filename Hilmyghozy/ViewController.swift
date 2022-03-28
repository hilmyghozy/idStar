//
//  ViewController.swift
//  Hilmyghozy
//
//  Created by hilmy ghozy on 28/03/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var tabButton: [UIButton]!
    
    var arrItem: [TaskAll] = []{
        didSet{
            tableView.reloadData()
        }
    }
    
    var arrComplete: [TaskAll] = []{
        didSet{
            tableView.reloadData()
        }
    }
    
    var arrUncomplete: [TaskAll] = []{
        didSet{
            tableView.reloadData()
        }
    }
    
    var isSelected = 101
    let presenter: TaskPresenter = TaskPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(
            UINib(nibName: "TaskTableViewCell", bundle: nil),
            forCellReuseIdentifier: "TaskTableViewCell")
        
        
        setupView()
    }
    
    func setupView(){
        if isSelected == 101 {
            self.presenter.doGetAllItem()
            tabButton.first?.setTitleColor(UIColor.fontColor, for: .normal)
        }
        
        for btn in tabButton {
            btn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        }
    }

    @objc func btnClicked(_ sender: UIButton){
        if (sender.tag == 101) {
            self.isSelected = 101
            presenter.doGetAllItem()
            
        }else if (sender.tag == 102){
            self.isSelected = 102
            presenter.doGetCompletedItem()
            
        }else if (sender.tag == 103){
            self.isSelected = 103
            presenter.doGetUncompletedItem()
        }
        
        for btn in tabButton {
            
            if sender.tag == btn.tag {
                btn.setTitleColor(UIColor.fontColor, for: .normal)
            }else{
                btn.setTitleColor(UIColor.gray, for: .normal)
            }
        }
        
    }

}

extension ViewController: TaskDelegate {
    func didSuccessGetItemsCompleted() {
        if let data = self.presenter.responseItemsCompleted{
            self.arrComplete = data
            print("Completed done", isSelected)
        }
    }
    
    func didSuccessGetItemsUncompleted() {
        if let data = self.presenter.responseItemsUncompleted{
            self.arrUncomplete = data
            print("Uncompleted done",isSelected)
        }
    }
    
    func didSuccessGetItems() {
        if let data = self.presenter.responseItems{
            self.arrItem = data
            print("allTask done",isSelected)
        }
    }
    
    func didFailedGetItems(errorMessage: String) {
        print("failled",errorMessage)
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch isSelected {
        case 101:
            return arrItem.count
        case 102:
            return arrComplete.count
        case 103:
            return arrUncomplete.count
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        switch isSelected {
        case 101:
            cell.arrItem = arrItem[indexPath.row]
            cell.selectionStyle = .none
            return cell
        case 102:
            cell.arrItem = arrComplete[indexPath.row]
            cell.selectionStyle = .none
            return cell
        case 103:
            cell.arrItem = arrUncomplete[indexPath.row]
            cell.selectionStyle = .none
            return cell
        default:
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
