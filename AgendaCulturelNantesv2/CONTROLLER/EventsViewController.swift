//
//  EventsViewController.swift
//  AgendaCulturelNantesv2
//
//  Created by fred on 03/07/2020.
//  Copyright © 2020 fred. All rights reserved.
//

import UIKit
import FSCalendar

class EventsViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayDateButton: UIButton!
    
    var calendar = CalendarViewController()
    var date = NSDate()
    static var currentDay: String = ""
    private static var array = [records]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        currentEvents(selecteDate: currentDate)
    }
    
    private func setupButton() {
        currentDay()
        dayDateButton.layer.borderWidth = 1
        dayDateButton.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        dayDateButton.layer.cornerRadius = 12
    }
    
    private func currentEvents(selecteDate: String) {
        QueryService.shared.get(dateSelected: selecteDate) { (result) in
            switch result {
            case .failure(let error) :
                print(error)
            case .success(let eventsData) :
                self.update(with: eventsData.records)
            }
        }
    }
    
    private func update(with events: [records]) {
        
        EventsViewController.array = events
        // sort array
        let manifSorted = events.sorted(by: {$0.fields.id_manif < $1.fields.id_manif})
        EventsViewController.array = manifSorted
        
        tableView.reloadData()
    }
    
    @IBAction func dayDateButtonPressed() {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let calendarView = sb.instantiateViewController(identifier: "calendar") as? CalendarViewController {
        self.present(calendarView, animated: true, completion: nil)
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "saveDate"), object: nil, queue: OperationQueue.main) { (notification) in
            let dateVC = notification.object as! CalendarViewController
            self.dayDateButton.setTitle(dateVC.saveDateSelected, for: .normal)
            self.dateLabel.text = dateVC.stringDay
            self.currentEvents(selecteDate: dateVC.dateSelected)
        }
        
    }
    
}
extension EventsViewController: FSCalendarDelegate {
    // current date
    private func currentDay() {
        let formatted = DateFormatter()
        formatted.dateStyle = .full
        formatted.locale = Locale(identifier: "FR_fr")
        formatted.dateFormat = "dd-MM-YYYY"
        EventsViewController.currentDay = formatted.string(from: date as Date)
    
        dayDateButton.setTitle(EventsViewController.currentDay, for: .normal)
    }
    // date for request events
    var currentDate: String {
        let formatterDate = DateFormatter()
        formatterDate.locale = Locale(identifier: "fr_FR")
        formatterDate.dateFormat = "YYYY-MM-dd"
        return formatterDate.string(from: date as Date)
    }
}
extension EventsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventsViewController.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventsList", for: indexPath) as? EventsTableViewCell else { return UITableViewCell() }
        
        let event = EventsViewController.array[indexPath.row]
        
        let complet: String
        let gratuit: String
        
        if event.fields.complet == "non" { complet = "" } else { complet = "complet" }
        if event.fields.gratuit == "non" { gratuit = "" } else { gratuit = "gratuit" }
        
        if let url = URL(string: event.fields.media_1 ?? "") {
        let request = URLRequest(url: url)
            
            cell.configure(nom: event.fields.nom, date: dateLabel.text ?? "", gratuit: gratuit, complet: complet, imageUrl: request)
        }
        return cell
        
    }
}
extension EventsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail: DetailViewController = self.storyboard?.instantiateViewController(identifier: "detail") as! DetailViewController
        let path = EventsViewController.array[indexPath.row]
        detail.detailLieu = path.fields.lieu
        detail.detailAdresse = path.fields.adresse
        detail.detailVille = path.fields.ville
        detail.detailDescription = path.fields.description
        detail.detailInfoSup = path.fields.info_suppl ?? ""
        detail.detailPrecisionsTarif = path.fields.precisions_tarifs ?? ""
        detail.detailMedia = path.fields.media_1 ?? ""
        
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
