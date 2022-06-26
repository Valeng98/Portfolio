//
//  MonthlyCalendar.swift
//  Calendar
//
//  Created by Valentina Guarnizo on 26/06/22.
//

import UIKit

class MonthlyCalendarViewController: UIViewController {

    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var totalSquares = [CalendarDay]()
    let calendarHelper = CalendarHelper()
    var selectedDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCellsView()
        setMonthView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setMonthView()
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    func setCellsView() {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setMonthView() {
        totalSquares.removeAll()
        
        let daysInMonth = calendarHelper.daysInMonth(date: selectedDate)
        let firstDayOfMonth = calendarHelper.firstOfMonth(date: selectedDate)
        let startingSpaces = calendarHelper.weekDay(date: firstDayOfMonth)
        
        let prevMonth = calendarHelper.minusMonth(date: selectedDate)
        let daysInPrevMonth = calendarHelper.daysInMonth(date: prevMonth)
        
        var count: Int = 1
        
        while(count <= 42) {
            let calendarDay = CalendarDay()
            if count <= startingSpaces {
                let prevMonthDay = daysInPrevMonth - startingSpaces + count
                calendarDay.day = String(prevMonthDay)
                calendarDay.month = CalendarDay.Month.previous
            } else if count - startingSpaces > daysInMonth {
                calendarDay.day = String(count - daysInMonth - startingSpaces)
                calendarDay.month = CalendarDay.Month.next
            } else {
                calendarDay.day = String(count - startingSpaces)
                calendarDay.month = CalendarDay.Month.current
            }
            totalSquares.append(calendarDay)
            count += 1
        }
        
        monthLabel.text = calendarHelper.monthString(date: selectedDate)
            + " " + calendarHelper.yearString(date: selectedDate)
        collectionView.reloadData()
    }
    
    @IBAction func showWeeklyCalendar(_ sender: Any) {
        let storyboard = UIStoryboard(name: "WeeklyCalendar", bundle: nil)
        let weeklyCalendar = storyboard.instantiateViewController(withIdentifier: "WeeklyCalendar") as! WeeklyCalendarViewController
        
        navigationController?.pushViewController(weeklyCalendar, animated: true)
    }
    
    @IBAction func previousMonth(_ sender: Any) {
        selectedDate = calendarHelper.minusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func nextMonth(_ sender: Any) {
        selectedDate = calendarHelper.plusMonth(date: selectedDate)
        setMonthView()
    }
}

extension MonthlyCalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        let calendarDay = totalSquares[indexPath.item]
        
        cell.dayOfMonth.text = calendarDay.day
        if(calendarDay.month == CalendarDay.Month.current) {
            cell.dayOfMonth.textColor = UIColor.black
        } else {
            cell.dayOfMonth.textColor = UIColor.gray
        }
        
        return cell
    }
}
