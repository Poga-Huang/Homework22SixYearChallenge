//
//  ViewController.swift
//  Homework22SixYearChallenge
//
//  Created by 黃柏嘉 on 2021/11/25.
//

import UIKit
enum ShowDateMode{
    case datePicker
    case changeFormat
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var firstImage: coverImageView!
    @IBOutlet weak var nextImage: UIImageView!
    @IBOutlet weak var sixYearChallengeButton: UIButton!
    @IBOutlet weak var selectDatePicker: UIDatePicker!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var selectDateLabel: UILabel!
    @IBOutlet weak var yearSlider: UISlider!
    @IBOutlet weak var datePickerBackView: UIView!
    
    let degree = CGFloat.pi/180
    var isOpening = false
    var showDate = false
    var interval = 0
    let dateFormatter = DateFormatter()
    var timer:Timer?
    var timerYear = 2015
    var isPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始Button
        sixYearChallengeButton.transform = CGAffineTransform(rotationAngle: degree*340)
        
        //初始Label顯示時間
        interval = -Int(selectDatePicker.date.timeIntervalSinceNow)
        daysLabel.text = "\(interval/60/60/24) DAYS"
        //初始selectDateLabel
        let selectDate = selectDatePicker.date
        dateFormatter.dateFormat = "yyyy/MM/dd"
        selectDateLabel.text =  dateFormatter.string(from: selectDate)
       //初始Image
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from:selectDatePicker.date)
        firstImage.image = UIImage(named: "\(dateComponents.year!)")
            }
    
    //自動播放圖片
    @IBAction func autoChangeImage(_ sender: UIButton) {
        if isPlaying == false{
            timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(autoChangeImageMethod), userInfo: nil, repeats: true)
            isPlaying = true
            selectDatePicker.isUserInteractionEnabled = false
            yearSlider.isUserInteractionEnabled = false
        }else{
            timer?.invalidate()
            isPlaying = false
            selectDatePicker.isUserInteractionEnabled = true
            yearSlider.isUserInteractionEnabled = true
        }
        
        
    }
    @objc func autoChangeImageMethod(){
        changeImage(ImageName: String(timerYear))
        yearSlider.value = Float(timerYear)
        let dateComponents = DateComponents(calendar: Calendar.current, timeZone: nil, era: nil, year: timerYear, month: 10, day: 20, hour: nil, minute: nil, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
        selectDatePicker.setDate(dateComponents.date!, animated: true)
        selectDateLabel.text = dateFormatter.string(from: dateComponents.date!)
        showSelectDate(selectDate: dateComponents.date!, mode: .datePicker)
        timerYear += 1
        if timerYear == 2022{
            timerYear = 2015
        }
    }
    
    
    //PickerView開關
    @IBAction func openOrCloseDatePicker(_ sender: UIButton) {
        if isOpening == false{
            UIView.animate(withDuration: 1) {
                self.datePickerBackView.frame.origin.y -= 223
                sender.transform = CGAffineTransform.identity.rotated(by: self.degree*180)
                self.isOpening = true
            }
        }else{
            UIView.animate(withDuration: 1) {
                self.datePickerBackView.frame.origin.y += 223
                sender.transform = CGAffineTransform.identity.rotated(by: self.degree*360)
                self.isOpening = false

            }
        }
    }
    //滑桿變更圖片以及DatePicker
    @IBAction func slideToChangeImage(_ sender: UISlider) {
        let slideYear = lround(Double(sender.value))
        changeImage(ImageName: String(slideYear))
        let dateComponents = DateComponents(calendar: Calendar.current, timeZone: nil, era: nil, year: slideYear, month: 10, day: 20, hour: nil, minute: nil, second: nil, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
        selectDatePicker.setDate(dateComponents.date!, animated: true)
        selectDateLabel.text = dateFormatter.string(from: dateComponents.date!)
        showSelectDate(selectDate: dateComponents.date!, mode: .datePicker)
    }
    
    //轉動Picker顯示圖片及顯示幾天
    @IBAction func selectDate(_ sender: UIDatePicker) {
        showSelectDate(selectDate: sender.date, mode: .datePicker)
        selectDateLabel.text = dateFormatter.string(from: sender.date)
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from:selectDatePicker.date)
        if let dateComponentsYear = dateComponents.year{
            yearSlider.value = Float(dateComponentsYear)
            changeImage(ImageName:String(dateComponentsYear))
        }
        
    }
    
    //轉換顯示鍵
    @IBAction func changeFormat(_ sender: UIButton) {
       
        showSelectDate(selectDate: selectDatePicker.date, mode: .changeFormat)
    }
    //顯示日期轉換
    func showSelectDate(selectDate:Date,mode:ShowDateMode){
        switch mode{
        case.datePicker:
            if showDate == true{
                interval = -Int(selectDate.timeIntervalSinceNow)/60/60/24
                let years = interval/365
                let months = interval%365/31
                let days = interval%365%31
                daysLabel.text = "\(years) Y \(months) M \(days) D "
            }else{
                interval = -Int(selectDate.timeIntervalSinceNow)/60/60/24
                daysLabel.text = "\(interval) DAYS"
            }
        case.changeFormat:
            if showDate == true{
                interval = -Int(selectDate.timeIntervalSinceNow)/60/60/24
                let years = interval/365
                let months = interval%365/31
                let days = interval%365%31
                daysLabel.text = "\(years) Y \(months) M \(days) D "
                showDate = false
            }else{
                interval = -Int(selectDate.timeIntervalSinceNow)/60/60/24
                daysLabel.text = "\(interval) DAYS"
                showDate = true
            }
        }
        
        
    }
    func changeImage(ImageName:String){
        if firstImage.alpha == 1{
            UIView.animate(withDuration: 2) {
                self.nextImage.image = UIImage(named: "\(ImageName)")
                self.nextImage.alpha = 1
                self.firstImage.alpha = 0
            }
        }else{
            UIView.animate(withDuration: 2) {
                self.firstImage.image = UIImage(named: "\(ImageName)")
                self.firstImage.alpha = 1
                self.nextImage.alpha = 0
            }
        }
    }
    

}
