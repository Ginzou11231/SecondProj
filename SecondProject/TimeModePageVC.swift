//
//  TimeModePageVC.swift
//  SecondProject
//
//  Created by 邱裕芳 on 2023/6/14.
//

import UIKit
import SnapKit

protocol TimeModeDelegate{
    func setStartTime(setTime : String)
    func setEndTime(setTime : String)
}

class TimeModePageVC: UIViewController , UITextFieldDelegate , UICollectionViewDelegate , UICollectionViewDataSource , TimeModeDelegate , UIViewControllerTransitioningDelegate {
    
    func setStartTime(setTime : String){
        startTF.attributedText = NSAttributedString(string: setTime , attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24),
            NSAttributedString.Key.kern: 2 ,
            NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func setEndTime(setTime : String){
        endTF.attributedText = NSAttributedString(string: setTime , attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24),
            NSAttributedString.Key.kern: 2 ,
            NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }

    var titleBGView : UIView!
    var titleLabel , startLabel , endLabel , timerLabel : UILabel!
    var backBtn , startBtn : UIButton!
    var startTF , endTF : UITextField!
    
    var timerFL : UICollectionViewFlowLayout!
    var timerCV : UICollectionView!
    
    var startDate , endDate : Date!
    var formatter : DateFormatter!
    
    var showSelect : [Bool] = []
    var timerArray : [TimerModel] = []
    
    var customTimerDelegate : CustomTimerArrayDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiInit()
        setArrayData()
    }
    
    func setArrayData(){
        if timerArray.count == 0{
            for i in 0..<13{
                switch i {
                case 0:
                    let model = TimerModel()
                    model.checkNumber = i
                    model.hour = 0
                    model.min = 0
                    model.sec = 30
                    timerArray.append(model)
                case 1 :
                    let model = TimerModel()
                    model.checkNumber = i
                    model.hour = 0
                    model.min = 1
                    model.sec = 0
                    timerArray.append(model)
                case 2:
                    let model = TimerModel()
                    model.checkNumber = i
                    model.hour = 0
                    model.min = 3
                    model.sec = 0
                    timerArray.append(model)
                case 3 :
                    let model = TimerModel()
                    model.checkNumber = i
                    model.hour = 0
                    model.min = 5
                    model.sec = 0
                    timerArray.append(model)
                case 4 :
                    let model = TimerModel()
                    model.checkNumber = i
                    model.hour = 0
                    model.min = 10
                    model.sec = 0
                    timerArray.append(model)
                case 5 :
                    let model = TimerModel()
                    model.checkNumber = i
                    model.hour = 0
                    model.min = 15
                    model.sec = 0
                    timerArray.append(model)
                case 6 :
                    let model = TimerModel()
                    model.checkNumber = i
                    model.hour = 0
                    model.min = 20
                    model.sec = 0
                    timerArray.append(model)
                case 7 :
                    let model = TimerModel()
                    model.checkNumber = i
                    model.hour = 0
                    model.min = 30
                    model.sec = 0
                    timerArray.append(model)
                case 8 :
                    let model = TimerModel()
                    model.checkNumber = i
                    model.hour = 0
                    model.min = 45
                    model.sec = 0
                    timerArray.append(model)
                case 9 :
                    let model = TimerModel()
                    model.checkNumber = i
                    model.hour = 1
                    model.min = 0
                    model.sec = 0
                    timerArray.append(model)
                case 10 :
                    let model = TimerModel()
                    model.checkNumber = i
                    model.hour = 1
                    model.min = 30
                    model.sec = 0
                    timerArray.append(model)
                case 11 :
                    let model = TimerModel()
                    model.checkNumber = i
                    model.hour = 2
                    model.min = 0
                    model.sec = 0
                    timerArray.append(model)
                case 12 :
                    let model = TimerModel()
                    model.checkNumber = i
                    model.hour = 3
                    model.min = 0
                    model.sec = 0
                    timerArray.append(model)
                default:
                    break
                }
            }
        }
        for _ in 0..<timerArray.count + 1{
            showSelect.append(false)
        }
    }
    
    func uiInit(){
        view.backgroundColor = UIColor(cgColor: CGColor(red: 171 / 255, green: 225 / 255, blue: 254 / 255, alpha: 1))
        
        titleBGView = UIView()
        titleBGView.backgroundColor = UIColor(cgColor: CGColor(red: 79 / 255, green: 177 / 255, blue: 252 / 255, alpha: 1))
        view.addSubview(titleBGView)
        titleBGView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        titleLabel = UILabel()
        titleLabel.attributedText = NSAttributedString(string: "Timer Mode" , attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize:24),
            NSAttributedString.Key.kern: 2 ,
            NSAttributedString.Key.foregroundColor: UIColor(cgColor: CGColor(red: 2 / 255, green: 69 / 255, blue: 113 / 255, alpha: 1))])
        
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        backBtn = UIButton()
        backBtn.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        
        backBtn.tintColor = UIColor(cgColor: CGColor(red: 2 / 255, green: 69 / 255, blue: 113 / 255, alpha: 1))
        backBtn.addTarget(self, action: #selector(backBtnAction(sender:)), for: .touchUpInside)
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(titleLabel)
            make.leading.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        startLabel = UILabel()
        startLabel.attributedText = NSAttributedString(string: "Start Time" , attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.kern: 1 ,
            NSAttributedString.Key.foregroundColor: UIColor(cgColor: CGColor(red: 79 / 255, green: 177 / 255, blue: 252 / 255, alpha: 1))])
        startLabel.textAlignment = .center
        view.addSubview(startLabel)
        startLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        
        startTF = UITextField()
        startTF.textAlignment = .center
        startTF.attributedText = NSAttributedString(string: "00 : 00 : 00" , attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24),
            NSAttributedString.Key.kern: 2 ,
            NSAttributedString.Key.foregroundColor: UIColor.white])
        
        startTF.backgroundColor = UIColor(cgColor: CGColor(red: 79 / 255, green: 177 / 255, blue: 252 / 255, alpha: 1))
        startTF.layer.cornerRadius = 25
        startTF.delegate = self
        
        view.addSubview(startTF)
        startTF.snp.makeConstraints { make in
            make.top.equalTo(startLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
        
        endLabel = UILabel()
        endLabel.attributedText = NSAttributedString(string: "End Time" , attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.kern: 1 ,
            NSAttributedString.Key.foregroundColor: UIColor(cgColor: CGColor(red: 79 / 255, green: 177 / 255, blue: 252 / 255, alpha: 1))])
        endLabel.textAlignment = .center
        view.addSubview(endLabel)
        endLabel.snp.makeConstraints { make in
            make.top.equalTo(startTF.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        
        endTF = UITextField()
        endTF.textAlignment = .center
        endTF.attributedText = NSAttributedString(string: "00 : 00 : 00" , attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24),
            NSAttributedString.Key.kern: 2 ,
            NSAttributedString.Key.foregroundColor: UIColor.white])
        
        endTF.backgroundColor = UIColor(cgColor: CGColor(red: 79 / 255, green: 177 / 255, blue: 252 / 255, alpha: 1))
        endTF.layer.cornerRadius = 25
        endTF.delegate = self
        
        view.addSubview(endTF)
        endTF.snp.makeConstraints { make in
            make.top.equalTo(endLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
        
        timerLabel = UILabel()
        timerLabel.attributedText = NSAttributedString(string: "Timer" , attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.kern: 1 ,
            NSAttributedString.Key.foregroundColor: UIColor(cgColor: CGColor(red: 79 / 255, green: 177 / 255, blue: 252 / 255, alpha: 1))])
        timerLabel.textAlignment = .center
        view.addSubview(timerLabel)
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(endTF.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        
        startBtn = UIButton()
        startBtn.setAttributedTitle(NSAttributedString(string: "START" , attributes: [
            NSAttributedString.Key.kern: 10 ,
            NSAttributedString.Key.foregroundColor: UIColor.white ,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]), for: .normal)
        
        startBtn.setAttributedTitle(NSAttributedString(string: "START" , attributes: [
            NSAttributedString.Key.kern: 10 ,
            NSAttributedString.Key.foregroundColor: UIColor.lightGray ,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)]), for: .highlighted)
        
        startBtn.setBackgroundColor(color: UIColor(cgColor: CGColor(red: 79 / 255, green: 177 / 255, blue: 252 / 255, alpha: 1)), forState: .normal)
        startBtn.setBackgroundColor(color: UIColor(cgColor: CGColor(red: 39.5 / 255, green: 88.5 / 255, blue: 126 / 255, alpha: 1)), forState: .highlighted)
        
        startBtn.layer.cornerRadius = 25
        startBtn.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        startBtn.layer.borderWidth = 3

        startBtn.addTarget(self, action: #selector(startBtnAction(sender:)), for: .touchUpInside)
        view.addSubview(startBtn)
        startBtn.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-30)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
        
        
        timerFL = UICollectionViewFlowLayout()
        timerFL.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        timerFL.itemSize = CGSize(width: UIScreen.main.bounds.width / 4 - 30, height: UIScreen.main.bounds.width / 4 - 30)
        timerFL.minimumLineSpacing = 20
        timerFL.scrollDirection = .vertical
        
        
        timerCV = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: timerFL)
        timerCV.dataSource = self
        timerCV.delegate = self
        timerCV.register(TimerCollectionCell.self, forCellWithReuseIdentifier: TimerCollectionCell.cellIdentifier)
        timerCV.backgroundColor = .clear
        timerCV.layer.cornerRadius = 20
        timerCV.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        timerCV.layer.borderWidth = 3
        view.addSubview(timerCV)
        timerCV.snp.makeConstraints { make in
            make.top.equalTo(timerLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalTo(startBtn.snp.top).offset(-30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timerArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimerCollectionCell.cellIdentifier, for: indexPath) as! TimerCollectionCell
        
        if showSelect[indexPath.item]{
            cell.backgroundColor = UIColor(cgColor: CGColor(red: 2 / 255, green: 69 / 255, blue: 113 / 255, alpha: 1))
        }else{
            cell.backgroundColor = UIColor(cgColor: CGColor(red: 79 / 255, green: 177 / 255, blue: 252 / 255, alpha: 1))
        }
        
        if indexPath.item == timerArray.count{
            
            cell.numLabel.isHidden = true
            cell.unitLabel.isHidden = true
            cell.customLabel.isHidden = false

            return cell
            
        }else{
            let hour = timerArray[indexPath.item].hour
            let min = timerArray[indexPath.item].min
            let sec = timerArray[indexPath.item].sec
            
            var time = ""
            var unit = ""
            
            if hour == 0 && min == 0{
                if sec < 10 {
                    time += "0\(String(sec))"
                }else{
                    time += "\(String(sec))"
                }
                unit += "sec"
            }
            
            if hour == 0 && sec == 0{
                if min < 10 {
                    time += "0\(String(min))"
                }else{
                    time += "\(String(min))"
                }
                unit += "min"
            }
            
            if min == 0 && sec == 0{
                if hour < 10 {
                    time += "0\(String(hour))"
                }else{
                    time += "\(String(hour))"
                }
                unit += "hour"
            }
            
            if hour != 0 && min != 0 {
                var double = 0.0
                double += Double(hour)
                double += Double(min) / 60
                time = String(format: "%.1f", double)
                unit += "hour"
            }
            
            cell.numLabel.attributedText = NSAttributedString(string: time , attributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
                NSAttributedString.Key.kern: 1 ,
                NSAttributedString.Key.foregroundColor: UIColor(cgColor: CGColor(red: 1, green: 1 , blue: 1, alpha: 1))])
            
            cell.unitLabel.attributedText = NSAttributedString(string: unit , attributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
                NSAttributedString.Key.kern: 1 ,
                NSAttributedString.Key.foregroundColor: UIColor(cgColor: CGColor(red: 1, green: 1 , blue: 1, alpha: 1))])
            
            cell.numLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(15)
                make.centerX.equalToSuperview()
            }
            
            cell.numLabel.isHidden = false
            cell.unitLabel.isHidden = false
            cell.customLabel.isHidden = true
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0..<showSelect.count{
            showSelect[i] = false
        }
        showSelect[indexPath.item] = true
        timerCV.reloadData()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let vc = TimePickerVC()
        
//        if let sheetPresentationController = vc.sheetPresentationController {
//            sheetPresentationController.detents = [.medium()]
//        }
        
        if textField == startTF{
            vc.prevFrom = PrevFromEnum.start.rawValue
        }else{
            vc.prevFrom = PrevFromEnum.end.rawValue
        }
        vc.timeModeDelegate = self
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        
        present(vc ,animated: true)
        view.endEditing(true)
    }
    
    @objc func backBtnAction(sender : UIButton){
        dismiss(animated: true)
    }
    
    @objc func startBtnAction(sender : UIButton){
        
        formatter = DateFormatter()
        formatter.dateFormat = "HH : mm : ss"

        startDate = formatter.date(from: startTF.text!)
        endDate = formatter.date(from: endTF.text!)
        
        if startDate == endDate{
            let ac = UIAlertController(title: nil, message: "StartTime And EndTime\nCan't Same Value\n\nPlease Set Again\nStartTime And EndTime", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            ac.addAction(ok)
            present(ac, animated: true)
        }else{
            var index = 0
            var selectCheck = true
            var array : [TimerModel] = []
            
            for i in 0..<showSelect.count{

                if showSelect[i] == true{
                    index = i
                    selectCheck = false
                    break
                }
            }

            if selectCheck{
                let ac = UIAlertController(title: nil, message: "Please Select Timer", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                ac.addAction(ok)
                present(ac, animated: true)
                return
            }
            
            if index == showSelect.count - 1{
                array = customTimerDelegate.getTimers()
                
                if array.count == 0{
                    let ac = UIAlertController(title: nil, message: "Your CustomTimer No Setting\nPlease Set Your CustomTimer Data ", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default) { Action in
                        let vc = CustomizeModePageVC()
                        vc.modalPresentationStyle = .fullScreen
                        vc.customTimerArray = self.customTimerDelegate
                        self.present(vc , animated: true)
                    }
                    ac.addAction(ok)
                    present(ac, animated: true)
                    return
                }
            }else{
                array.append(timerArray[index])
            }
            
            let vc = CountDownPageVC()
            vc.modalPresentationStyle = .fullScreen
            
            vc.startTimeDate = startDate
            vc.endTimeDate = endDate
            vc.TimerArray = array
            
            present(vc , animated: true)
        }
    }


}
