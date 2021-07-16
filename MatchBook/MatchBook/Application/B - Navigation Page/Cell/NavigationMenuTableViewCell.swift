//
//  NavigationMenuTableViewCell.swift
//  MatchBook
//
//  Created by Mauro De Vito on 14/07/2021.
//

import UIKit


class NavigationMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var leftSpaceLabelName: NSLayoutConstraint!
    private let leftSpace: CGFloat = 16
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setupCell(item: NavigationItemUIModel) {
        self.labelName.text = item.name
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftSpaceLabelName.constant = leftSpace + (leftSpace * CGFloat(item.level.rawValue) * 2)
    }
    
}
