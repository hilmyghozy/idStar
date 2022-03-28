//
//  TaskTableViewCell.swift
//  Hilmyghozy
//
//  Created by hilmy ghozy on 28/03/22.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var titleContent: UILabel!
    @IBOutlet weak var levelPriority: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var containerView: UIView!{
        didSet{
            containerView.layer.cornerRadius = 10
        }
    }
    
    var arrItem: TaskAll! {
        didSet {
            guard let arrItem = arrItem else { return }
            
            levelPriority.text = arrItem.priority
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "dd/mm/yyyy"

            if let date = dateFormatterGet.date(from: arrItem.createdAt) {
                dateLabel.text = dateFormatterPrint.string(from: date)
            }else {
               print("There was an error decoding the string")
            }
            
            if arrItem.status == "completed"{
                titleContent.attributedText = "\(arrItem.task)".strikeThrough()
            }else{
                titleContent.attributedText = arrItem.task.reset()
            }
            
            toggleTask(arrItem.status == "completed" ? true : false)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleContent.attributedText = .none
        levelPriority.text = ""
        dateLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func toggleTask(_ bookmarked: Bool) {
        let name = bookmarked ? "check" : "square"
        let sepColor = bookmarked ? UIColor.green : UIColor.red
        let bookmark = UIImage(named: name)?.withRenderingMode(.alwaysTemplate)
        checkBox.setImage(bookmark, for: .normal)
        checkBox.imageView?.tintColor = UIColor.fontColor
        
        separatorView.backgroundColor = sepColor
        
        
        //bookmarkButton.imageView?.tintColor = UIColor.white
    }
    
}
