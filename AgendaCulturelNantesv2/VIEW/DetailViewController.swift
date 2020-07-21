//
//  DetailViewController.swift
//  AgendaCulturelNantesv2
//
//  Created by fred on 01/07/2020.
//  Copyright © 2020 fred. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var webImageMedia: WKWebView!
    @IBOutlet weak var lieuLabel: UILabel!
    @IBOutlet weak var adresseLabel: UILabel!
    @IBOutlet weak var villeLabel: UILabel!
    
    var detailMedia = ""
    var detailNom = ""
    var detailDate = ""
    var detailHeureDebut = ""
    var detailLieu = ""
    var detailAdresse = ""
    var detailVille = ""
    var detailInfoSup = ""
    var detailDescription = ""
    var detailPrecisionsTarif = ""
    
    static var info: [DetailsInfo] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lieuLabel.text = detailLieu
        adresseLabel.text = detailAdresse
        villeLabel.text = detailVille
        print(detailMedia)
        if let url = URL(string: detailMedia) {
        let request = URLRequest(url: url)
        webImageMedia.load(request)
        }
        DetailViewController.info.append(DetailsInfo(name: "Description", body: detailDescription))
        DetailViewController.info.append(DetailsInfo(name: "Date et Horaires", body: detailInfoSup))
        DetailViewController.info.append(DetailsInfo(name: "Moyens de Paiement", body: detailPrecisionsTarif))
        
        tableView.reloadData()
    }
    
}
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DetailViewController.info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        let infos = DetailViewController.info[indexPath.row]
        cell.textLabel?.text = infos.name
        cell.detailTextLabel?.text = infos.body
        return cell
    }
    
    
}
