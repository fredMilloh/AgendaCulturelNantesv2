//
//  CalendarViewController.swift
//  AgendaCulturelNantesv2
//
//  Created by fred on 07/07/2020.
//  Copyright © 2020 fred. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate {

    var calendar = FSCalendar()
    
    // date selected on calendar button title
    var saveDateSelected: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "dd-MM-YYYY"
        return formatter.string(from: calendar.selectedDate!)
    }
    
    //date selected on calendar for request
    var dateSelected: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter.string(from: calendar.selectedDate!)
    }
    
    // name of day
    var stringDay: String {
        let formatterDate = DateFormatter()
        formatterDate.locale = Locale(identifier: "fr_FR")
        formatterDate.dateFormat = "EEEE dd MMMM"
        return formatterDate.string(from: calendar.selectedDate!)
    }
    
    override func viewDidLoad() {
        calendar.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // put calendar on view
        calendar.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 250)
        calendar.backgroundColor = .white
        let locale = NSLocale(localeIdentifier: "fr_FR")
        calendar.locale = locale as Locale
        view.addSubview(calendar)
        
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "saveDate"), object: self)
        self.dismiss(animated: true, completion: nil)
    }
    
}
