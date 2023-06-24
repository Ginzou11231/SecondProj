//
//  TimePickerVC.swift
//  SecondProject
//
//  Created by 邱裕芳 on 2023/6/14.
//

import UIKit
import SnapKit

enum PrevFromEnum : Int{
    case start = 0
    case end = 1
    case append = 2
    case edit = 3
    
}
class TimePickerVC: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource {
    
    var prevFrom : Int!
    var timeModeDelegate : TimeModeDelegate!
    
    var editData : TimerModel!
    var arrayDelegate : TimerFunctionDelegate!
    
    var cancelBtn , doneBtn : UIButton!
    var timePV : UIPickerView!
    
    var hourArray , minArray , secArray: [Int]!
    var currentHour , currentMin , currentSec : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiInit()
        
        
        
        hourArray = []
        minArray = []
        secArray = []
        
        currentHour = 0
        currentMin = 0
        currentSec = 0
        
        for i in 0..<24{
            hourArray.append(i)
        }
        
        for i in 0..<60{
            minArray.append(i)
            secArray.append(i)
        }
    }
    
    func uiInit(){
        
        view.backgroundColor = UIColor(cgColor: CGColor(red: 1, green: 1, blue: 1, alpha: 1))
        
        cancelBtn = UIButton()
        cancelBtn.setAttributedTitle(NSAttributedString(string: "Cancel" , attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18) ,
            NSAttributedString.Key.foregroundColor: UIColor.systemBlue]), for: .normal)
        cancelBtn.setAttributedTitle(NSAttributedString(string: "Cancel" , attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18) ,
            NSAttributedString.Key.foregroundColor: UIColor.lightGray]), for: .highlighted)
        
        cancelBtn.titleLabel?.textAlignment = .center
        cancelBtn.backgroundColor = .clear
        cancelBtn.addTarget(self, action: #selector(cancelBtnAction(sender:)), for: .touchUpInside)
        view.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        doneBtn = UIButton()
        doneBtn.setAttributedTitle(NSAttributedString(string: "Done" , attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18) ,
            NSAttributedString.Key.foregroundColor: UIColor.systemBlue]), for: .normal)
        doneBtn.setAttributedTitle(NSAttributedString(string: "Done" , attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18) ,
            NSAttributedString.Key.foregroundColor: UIColor.lightGray]), for: .highlighted)
        
        doneBtn.titleLabel?.textAlignment = .center
        doneBtn.backgroundColor = .clear
        doneBtn.addTarget(self, action: #selector(doneBtnAction(sender:)), for: .touchUpInside)
        view.addSubview(doneBtn)
        doneBtn.snp.makeConstraints { make in
            make.top.equalTo(cancelBtn)
            make.right.equalToSuperview()
            make.width.equalTo(cancelBtn)
            make.height.equalTo(cancelBtn)
        }
        
        timePV = UIPickerView()
        timePV.delegate = self
        timePV.dataSource = self
        view.addSubview(timePV)
        timePV.snp.makeConstraints { make in
            make.top.equalTo(cancelBtn.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch component{
        case 0,2,4:
            return UIScreen.main.bounds.width / 5 - 20
        default:
            return UIScreen.main.bounds.width / 6 - 20
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 6
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case 0:
            return hourArray.count
        case 2,4:
            return minArray.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        switch component{
        case 0:
            return String(hourArray[row])
        case 1:
            return "h"
        case 2:
            return String(minArray[row])
        case 3:
            return "m"
        case 4:
            return String(secArray[row])
        case 5:
            return "s"
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch component{
        case 0:
            currentHour = hourArray[row]
        case 2:
            currentMin = minArray[row]
        case 4:
            currentSec = secArray[row]
        default:
            return
        }
    }
    
    @objc func cancelBtnAction(sender : UIButton){
        dismiss(animated: true)
    }
    
    @objc func doneBtnAction(sender : UIButton){
        
        if currentHour == 0 && currentMin == 0 && currentSec == 0 && prevFrom != PrevFromEnum.start.rawValue && prevFrom != PrevFromEnum.end.rawValue{
            let ac = UIAlertController(title: "Error", message: "Hour Min Sec equal 0\nPlease Set Timer Again", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            ac.addAction(ok)
            present(ac , animated: true)
            return
        }
        
        var str = ""
        
        if let hour = currentHour{
            if hour < 10 {
                str += "0\(String(hour)) : "
            }else{
                str += "\(String(hour)) : "
            }
        }
        
        if let min = currentMin{
            if min < 10{
                str += "0\(String(min)) : "
            }else{
                str += "\(String(min)) : "
            }
        }
        
        if let sec = currentSec{
            if sec < 10{
                str += "0\(String(sec))"
            }else{
                str += String(sec)
            }
        }
        
        switch prevFrom {
        case PrevFromEnum.start.rawValue:
            timeModeDelegate.setStartTime(setTime: str)
            
        case PrevFromEnum.end.rawValue:
            timeModeDelegate.setEndTime(setTime: str)
            
        case PrevFromEnum.append.rawValue:
            arrayDelegate.appendTimer(hour: currentHour, min: currentMin, sec: currentSec)
            
        case PrevFromEnum.edit.rawValue:
            arrayDelegate.editTimer(editdata: editData, hour: currentHour, min: currentMin, sec: currentSec)
            
        default:
            break
        }
        
        dismiss(animated: true)
    }
}
