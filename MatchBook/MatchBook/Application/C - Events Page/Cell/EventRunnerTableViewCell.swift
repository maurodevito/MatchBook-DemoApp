//
//  EventRunnerTableViewCell.swift
//  MatchBook
//
//  Created by Mauro De Vito on 16/07/2021.
//

import UIKit

class EventRunnerTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var backPrice: UILabel!
    @IBOutlet weak var layPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(runner: EventRunnerUIModel) {
        self.name.text = runner.name
        self.backPrice.text = runner.firstBackPrice
        self.layPrice.text = runner.firstLayPrice
    }
    
}
