//
//  EventsTableViewCell.swift
//  AgendaCulturelNantesv2
//
//  Created by fred on 15/07/2020.
//  Copyright © 2020 fred. All rights reserved.
//

import UIKit
import WebKit

class EventsTableViewCell: UITableViewCell, WKUIDelegate {
    
    var imageMédia = WKWebView()
    
    @IBOutlet weak var nomLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var gratuitLabel: UILabel!
    @IBOutlet weak var completLabel: UILabel!
    @IBOutlet weak var imageWebView: WKWebView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(nom: String, date: String, gratuit: String, complet: String, imageUrl: URLRequest) {
        nomLabel.text = nom
        dateLabel.text = date
        gratuitLabel.text = gratuit
        completLabel.text = complet
        DispatchQueue.main.async {
            self.imageWebView.load(imageUrl)
        }
        
    }
    
    
}
