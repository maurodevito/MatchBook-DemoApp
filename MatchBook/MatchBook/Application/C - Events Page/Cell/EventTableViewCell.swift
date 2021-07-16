//
//  EventTableViewCell.swift
//  MatchBook
//
//  Created by Mauro De Vito on 15/07/2021.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var market: UILabel!
    @IBOutlet weak var runnersTableView: UITableView!
    let rowHeight: CGFloat = 40
    
    var runnersModel: [EventRunnerUIModel] = [EventRunnerUIModel]()
    private let cellIdentifier = "EventRunnerTableViewCellIdentifier"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let nib = UINib(nibName: "EventRunnerTableViewCell", bundle: nil)
        self.runnersTableView.register(nib, forCellReuseIdentifier: cellIdentifier)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    func setup(event: EventSingleUIModel) {
        self.name.text = event.name
        self.date.text = event.date
        self.market.text = "Market \(event.market) of \(event.name)"
        self.runnersModel = event.runners
        self.runnersTableView.reloadData()
    }
    
}


extension EventTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.runnersModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as? EventRunnerTableViewCell
        cell?.setup(runner: runnersModel[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
}
