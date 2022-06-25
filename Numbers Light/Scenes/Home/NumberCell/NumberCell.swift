//
//  NumberCell.swift
//  Numbers Light
//
//  Created by El Mahdi Boukhris on 23/06/2022.
//

import UIKit
import AlamofireImage

class NumberCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            nameLabel.textColor = UIColor(named: "selectedCellTextColor")
            containerView.backgroundColor = .green
        } else {
            nameLabel.textColor = UIColor(named: "normalCellTextColor")
            containerView.backgroundColor = .white
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            nameLabel.textColor = UIColor(named: "highlightedCellTextColor")
            containerView.backgroundColor = .red
        } else {
            nameLabel.textColor = UIColor(named: "normalCellTextColor")
            containerView.backgroundColor = .white
        }
    }
    
    func populateView(withData data: NumberBO?) {
        // force use https to avoid allowing arbitrary loads of ATS
        if let url = data?.image?.replacingOccurrences(of: "http://", with: "https://") {
            let imageURL = URL(string: url)!
            avatar.af.setImage(withURL: imageURL)
        }
        
        nameLabel.text = data?.name ?? "-"
    }
}
