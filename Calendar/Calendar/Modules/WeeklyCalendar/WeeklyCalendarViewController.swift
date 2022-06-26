//
//  WeeklyCalendarViewController.swift
//  Calendar
//
//  Created by Valentina Guarnizo on 26/06/22.
//

import UIKit

class WeeklyCalendarViewController: UIViewController {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let calendarHelper = CalendarHelper()
    var totalSquares = [Date]()
    var selectedDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCellsView()
        setWeekView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setWeekView()
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    func setCellsView() {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2)
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setWeekView() {
        totalSquares.removeAll()
        
        var current = calendarHelper.sundayForDate(date: selectedDate)
        let nextSunday = calendarHelper.addDays(date: current, days: 7)
        
        while (current < nextSunday) {
            totalSquares.append(current)
            current = calendarHelper.addDays(date: current, days: 1)
        }
        
        monthLabel.text = calendarHelper.monthString(date: selectedDate)
            + " " + calendarHelper.yearString(date: selectedDate)
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    @IBAction func showDaily(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Daily", bundle: nil)
        let daily = storyboard.instantiateViewController(withIdentifier: "Daily") as! DailyViewController
        
        navigationController?.pushViewController(daily, animated: true)
    }
    
    @IBAction func addNewEvent(_ sender: Any) {
        let storyboard = UIStoryboard(name: "EventEdit", bundle: nil)
        let eventEdit = storyboard.instantiateViewController(withIdentifier: "EventEdit") as! EventEditViewController
        
        navigationController?.pushViewController(eventEdit, animated: true)
    }
    
    @IBAction func previousWeek(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: -7)
        setWeekView()
    }
    
    @IBAction func nextWeek(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: 7)
        setWeekView()
    }
}

extension WeeklyCalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        
        let date = totalSquares[indexPath.item]
        cell.dayOfMonth.text = String(CalendarHelper().dayOfMonth(date: date))
        
        if(date == selectedDate) {
            cell.backgroundColor = UIColor.systemGreen
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = totalSquares[indexPath.item]
        collectionView.reloadData()
        tableView.reloadData()
    }
}

extension WeeklyCalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Event().eventsForDate(date: selectedDate).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID") as! EventCell
        let event = Event().eventsForDate(date: selectedDate)[indexPath.row]
        cell.eventLabel.text = event.name + " " + CalendarHelper().timeString(date: event.date)
        return cell
    }
}

