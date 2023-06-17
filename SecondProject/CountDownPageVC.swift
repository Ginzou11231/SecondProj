//
//  CountDownPageVC.swift
//  SecondProject
//
//  Created by 邱裕芳 on 2023/6/16.
//

import UIKit
import SnapKit

class CountDownPageVC: UIViewController {
    
    var titleLabel , seperateLabel , startTimeLabel , endTimeLabel , countStateLabel : UILabel!
    
    var startHourLabel , startMinLabel , startSecLabel : UILabel!
    var startHMColonLabel, startMSColonLabel : UILabel!
    var endHourLabel , endMinLabel , endSecLabel : UILabel!
    var endHMColonLabel , endMSColonLabel : UILabel!
    var countHourLabel , countMinLabel , countSecLabel : UILabel!
    var countHMColonLabel , countMSColonLabel : UILabel!
    
    
    var startTimeDate , endTimeDate , currentDate : Date!
    var formatter = DateFormatter()
    
    var bgView : UIView!
    var clockIV , clockEffectIV : UIImageView!
    var cancelBtn, playBtn , nextBtn , closeBtn : UIButton!
    
    var circleBgView : UIView!
    var circularProgressBarView: CircleProgressBarView!
    
    var TimerArray : [TimerModel]!
    var currentArrayIndex : Int = 0
    var triggerTimer : Timer!
    var timeOffset : TimeInterval!
    var countHourInt , countMinInt , countSecInt : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiInit()
        setTriggerTimer()
    }
    
    func uiInit(){
        
        view.backgroundColor = UIColor(cgColor: CGColor(red: 171 / 255, green: 225 / 255, blue: 254 / 255, alpha: 1))
        
        bgView = UIView()
        bgView.layer.shadowOffset = CGSize(width: 2, height: 2)
        bgView.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        bgView.layer.shadowOpacity = 0.5
        bgView.layer.cornerRadius = UIScreen.main.bounds.width
        bgView.backgroundColor = UIColor(cgColor: CGColor(red: 79 / 255, green: 177 / 255, blue: 252 / 255, alpha: 1))
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-UIScreen.main.bounds.height / 1.35)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width * 2)
            make.height.equalTo(UIScreen.main.bounds.height)
        }
        
        titleLabel = UILabel()
        titleLabel.attributedText = NSAttributedString(string: "Stand Up+" , attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20) ,
            NSAttributedString.Key.foregroundColor : UIColor.yellow ,
            NSAttributedString.Key.kern: 3])
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        
        startTimeLabel = UILabel()
        startTimeLabel.text = "Start Time"
        startTimeLabel.textColor = .white
        startTimeLabel.textAlignment = .center
        startTimeLabel.font = .boldSystemFont(ofSize: 20)
        view.addSubview(startTimeLabel)
        startTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalToSuperview().offset(50)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        endTimeLabel = UILabel()
        endTimeLabel.text = "End Time"
        endTimeLabel.textColor = .white
        endTimeLabel.textAlignment = .center
        endTimeLabel.font = .boldSystemFont(ofSize: 20)
        view.addSubview(endTimeLabel)
        endTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.trailing.equalToSuperview().offset(-50)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        seperateLabel = UILabel()
        seperateLabel.text = "-"
        seperateLabel.font = .boldSystemFont(ofSize: 20)
        seperateLabel.textAlignment = .center
        seperateLabel.textColor = .yellow
        view.addSubview(seperateLabel)
        seperateLabel.snp.makeConstraints { make in
            make.top.equalTo(UIScreen.main.bounds.height / 7)
            make.centerX.equalToSuperview()
        }
        
        formatter.dateFormat = "ss"
        let startSec = formatter.string(from: startTimeDate)
        
        startSecLabel = UILabel()
        startSecLabel.attributedText = NSAttributedString(string: startSec , attributes: [
            NSAttributedString.Key.kern: 1])
        
        startSecLabel.font = .boldSystemFont(ofSize: 20)
        startSecLabel.textColor = .yellow
        startSecLabel.textAlignment = .center
        view.addSubview(startSecLabel)
        startSecLabel.snp.makeConstraints { make in
            make.top.equalTo(seperateLabel).offset(-8)
            make.trailing.equalTo(seperateLabel.snp.leading).offset(-30)
            make.width.equalTo(30)
            make.height.equalTo(40)
        }
        
        startMSColonLabel = UILabel()
        startMSColonLabel.text = ":"
        startMSColonLabel.font = .boldSystemFont(ofSize: 20)
        startMSColonLabel.textAlignment = .center
        startMSColonLabel.textColor = .yellow
        view.addSubview(startMSColonLabel)
        startMSColonLabel.snp.makeConstraints { make in
            make.top.equalTo(startSecLabel).offset(5)
            make.trailing.equalTo(startSecLabel.snp.leading)
            make.width.equalTo(20)
            make.height.equalTo(30)
        }
        
        formatter.dateFormat = "mm"
        let startMin = formatter.string(from: startTimeDate)
        
        startMinLabel = UILabel()
        startMinLabel.attributedText = NSAttributedString(string: startMin , attributes: [
            NSAttributedString.Key.kern: 1])
        
        startMinLabel.font = .boldSystemFont(ofSize: 20)
        startMinLabel.textColor = .yellow
        startMinLabel.textAlignment = .center
        view.addSubview(startMinLabel)
        startMinLabel.snp.makeConstraints { make in
            make.top.equalTo(startSecLabel)
            make.trailing.equalTo(startMSColonLabel.snp.leading)
            make.width.equalTo(startSecLabel)
            make.height.equalTo(startSecLabel)
        }
        
        startHMColonLabel = UILabel()
        startHMColonLabel.text = ":"
        startHMColonLabel.font = .boldSystemFont(ofSize: 20)
        startHMColonLabel.textAlignment = .center
        startHMColonLabel.textColor = .yellow
        view.addSubview(startHMColonLabel)
        startHMColonLabel.snp.makeConstraints { make in
            make.top.equalTo(startMSColonLabel)
            make.trailing.equalTo(startMinLabel.snp.leading)
            make.width.equalTo(startMSColonLabel)
            make.height.equalTo(startMSColonLabel)
        }
        
        formatter.dateFormat = "HH"
        let startHour = formatter.string(from: startTimeDate)
        
        startHourLabel = UILabel()
        startHourLabel.attributedText = NSAttributedString(string: startHour , attributes: [
            NSAttributedString.Key.kern: 1])
        
        startHourLabel.font = .boldSystemFont(ofSize: 20)
        startHourLabel.textColor = .yellow
        startHourLabel.textAlignment = .center
        view.addSubview(startHourLabel)
        startHourLabel.snp.makeConstraints { make in
            make.top.equalTo(startSecLabel)
            make.trailing.equalTo(startHMColonLabel.snp.leading)
            make.width.equalTo(startSecLabel)
            make.height.equalTo(startSecLabel)
        }
        
        formatter.dateFormat = "HH"
        let endHour = formatter.string(from: endTimeDate)
        
        endHourLabel = UILabel()
        endHourLabel.attributedText = NSAttributedString(string: endHour , attributes: [
            NSAttributedString.Key.kern: 1])
        
        endHourLabel.font = .boldSystemFont(ofSize: 20)
        endHourLabel.textColor = .yellow
        endHourLabel.textAlignment = .center
        view.addSubview(endHourLabel)
        endHourLabel.snp.makeConstraints { make in
            make.top.equalTo(startSecLabel)
            make.leading.equalTo(seperateLabel.snp.trailing).offset(30)
            make.width.equalTo(startSecLabel)
            make.height.equalTo(startSecLabel)
        }
        
        endHMColonLabel = UILabel()
        endHMColonLabel.text = ":"
        endHMColonLabel.font = .boldSystemFont(ofSize: 20)
        endHMColonLabel.textAlignment = .center
        endHMColonLabel.textColor = .yellow
        view.addSubview(endHMColonLabel)
        endHMColonLabel.snp.makeConstraints { make in
            make.top.equalTo(startMSColonLabel)
            make.leading.equalTo(endHourLabel.snp.trailing)
            make.width.equalTo(startMSColonLabel)
            make.height.equalTo(startMSColonLabel)
        }
        
        formatter.dateFormat = "mm"
        let endMin = formatter.string(from: endTimeDate)
        
        endMinLabel = UILabel()
        endMinLabel.attributedText = NSAttributedString(string: endMin , attributes: [
            NSAttributedString.Key.kern: 1])
        
        endMinLabel.font = .boldSystemFont(ofSize: 20)
        endMinLabel.textColor = .yellow
        endMinLabel.textAlignment = .center
        view.addSubview(endMinLabel)
        endMinLabel.snp.makeConstraints { make in
            make.top.equalTo(startSecLabel)
            make.leading.equalTo(endHMColonLabel.snp.trailing)
            make.width.equalTo(startSecLabel)
            make.height.equalTo(startSecLabel)
        }
        
        endMSColonLabel = UILabel()
        endMSColonLabel.text = ":"
        endMSColonLabel.font = .boldSystemFont(ofSize: 20)
        endMSColonLabel.textAlignment = .center
        endMSColonLabel.textColor = .yellow
        view.addSubview(endMSColonLabel)
        endMSColonLabel.snp.makeConstraints { make in
            make.top.equalTo(startMSColonLabel)
            make.leading.equalTo(endMinLabel.snp.trailing)
            make.width.equalTo(startMSColonLabel)
            make.height.equalTo(startMSColonLabel)
        }
        
        formatter.dateFormat = "ss"
        let endSec = formatter.string(from: endTimeDate)
        
        endSecLabel = UILabel()
        endSecLabel.attributedText = NSAttributedString(string: endSec , attributes: [
            NSAttributedString.Key.kern: 1])
        
        endSecLabel.font = .boldSystemFont(ofSize: 20)
        endSecLabel.textColor = .yellow
        endSecLabel.textAlignment = .center
        view.addSubview(endSecLabel)
        endSecLabel.snp.makeConstraints { make in
            make.top.equalTo(startSecLabel)
            make.leading.equalTo(endMSColonLabel.snp.trailing)
            make.width.equalTo(startSecLabel)
            make.height.equalTo(startSecLabel)
        }
        
        circleBgView = UIView()
        circleBgView.backgroundColor = UIColor(cgColor: CGColor(red: 2 / 255, green: 69 / 255, blue: 113 / 255, alpha: 1))
        circleBgView.layer.cornerRadius = 150
        view.addSubview(circleBgView)
        circleBgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(300)
        }
        
        circularProgressBarView = CircleProgressBarView(frame: .zero)
        view.addSubview(circularProgressBarView)
        circularProgressBarView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        countStateLabel = UILabel()
        countStateLabel.attributedText = NSAttributedString(string: "Start Timer" ,attributes: [NSAttributedString.Key.kern: 2 ])
        countStateLabel.font = .boldSystemFont(ofSize: 30)
        countStateLabel.textColor = .white
        countStateLabel.textAlignment = .center
        view.addSubview(countStateLabel)
        countStateLabel.snp.makeConstraints { make in
            make.centerX.equalTo(circleBgView)
            make.top.equalTo(circleBgView).offset(80)
        }
        
        countMinLabel = UILabel()
        countMinLabel.attributedText = NSAttributedString(string: "00" ,attributes: [NSAttributedString.Key.kern: 2 ])
        countMinLabel.font = .boldSystemFont(ofSize: 50)
        countMinLabel.textColor = .white
        countMinLabel.textAlignment = .center
        view.addSubview(countMinLabel)
        countMinLabel.snp.makeConstraints { make in
            make.center.equalTo(circleBgView)
        }
        
        countHMColonLabel = UILabel()
        countHMColonLabel.text = ":"
        countHMColonLabel.font = .boldSystemFont(ofSize: 50)
        countHMColonLabel.textColor = .white
        countHMColonLabel.textAlignment = .center
        view.addSubview(countHMColonLabel)
        countHMColonLabel.snp.makeConstraints { make in
            make.top.equalTo(countMinLabel).offset(-5)
            make.trailing.equalTo(countMinLabel.snp.leading)
            make.width.equalTo(15)
            make.height.equalTo(countMinLabel)
        }
        
        countMSColonLabel = UILabel()
        countMSColonLabel.text = ":"
        countMSColonLabel.font = .boldSystemFont(ofSize: 50)
        countMSColonLabel.textColor = .white
        countMSColonLabel.textAlignment = .center
        view.addSubview(countMSColonLabel)
        countMSColonLabel.snp.makeConstraints { make in
            make.top.equalTo(countMinLabel).offset(-5)
            make.leading.equalTo(countMinLabel.snp.trailing)
            make.width.equalTo(15)
            make.height.equalTo(countMinLabel)
        }
        
        countHourLabel = UILabel()
        countHourLabel.attributedText = NSAttributedString(string: "00" ,attributes: [NSAttributedString.Key.kern: 2 ])
        countHourLabel.font = .boldSystemFont(ofSize: 50)
        countHourLabel.textColor = .white
        countHourLabel.textAlignment = .center
        view.addSubview(countHourLabel)
        countHourLabel.snp.makeConstraints { make in
            make.top.equalTo(countMinLabel)
            make.trailing.equalTo(countHMColonLabel.snp.leading)
            make.width.equalTo(countMinLabel)
            make.height.equalTo(countMinLabel)
        }
        
        countSecLabel = UILabel()
        countSecLabel.attributedText = NSAttributedString(string: "00" ,attributes: [NSAttributedString.Key.kern: 2 ])
        countSecLabel.font = .boldSystemFont(ofSize: 50)
        countSecLabel.textColor = .white
        countSecLabel.textAlignment = .center
        view.addSubview(countSecLabel)
        countSecLabel.snp.makeConstraints { make in
            make.top.equalTo(countMinLabel)
            make.leading.equalTo(countMSColonLabel.snp.trailing)
            make.width.equalTo(countMinLabel)
            make.height.equalTo(countMinLabel)
        }
        
        playBtn = UIButton()
        playBtn.setBackgroundImage(UIImage(named: "pause_icon"), for: .normal)
        playBtn.isSelected = true
        playBtn.addTarget(self, action: #selector(playBtnAction(sender:)), for: .touchUpInside)
        view.addSubview(playBtn)
        playBtn.isEnabled = false
        playBtn.alpha = 0.5
        playBtn.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-40)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        cancelBtn = UIButton()
        cancelBtn.setBackgroundImage(UIImage(named: "cancel_icon"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(cancelBtnAction(sender:)), for: .touchUpInside)
        view.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-80)
            make.leading.equalToSuperview().offset(30)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        nextBtn = UIButton()
        nextBtn.setBackgroundImage(UIImage(named: "next_icon"), for: .normal)
        nextBtn.addTarget(self, action: #selector(nextBtnAction(sender:)), for: .touchUpInside)
        nextBtn.isEnabled = false
        nextBtn.alpha = 0.5
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-80)
            make.trailing.equalToSuperview().offset(-30)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        clockIV = UIImageView()
        clockIV.image = UIImage(named: "clock_image")
        clockIV.isHidden = true
        view.addSubview(clockIV)
        clockIV.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        clockEffectIV = UIImageView()
        clockEffectIV.image = UIImage(named: "clockeffect_image")
        clockEffectIV.isHidden = true
        view.addSubview(clockEffectIV)
        clockEffectIV.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        closeBtn = UIButton()
        closeBtn.setAttributedTitle(NSAttributedString(string: "Close" , attributes: [
            NSAttributedString.Key.kern: 3 ,
            NSAttributedString.Key.foregroundColor: UIColor.white ,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]), for: .normal)
        
        closeBtn.setAttributedTitle(NSAttributedString(string: "Close" , attributes: [
            NSAttributedString.Key.kern: 3 ,
            NSAttributedString.Key.foregroundColor: UIColor.lightGray ,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)]), for: .highlighted)
        
        closeBtn.setBackgroundColor(color: UIColor(cgColor: CGColor(red: 79 / 255, green: 177 / 255, blue: 252 / 255, alpha: 1)), forState: .normal)
        closeBtn.setBackgroundColor(color: UIColor(cgColor: CGColor(red: 39.5 / 255, green: 88.5 / 255, blue: 126 / 255, alpha: 1)), forState: .highlighted)
        
        closeBtn.layer.cornerRadius = 25
        closeBtn.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        closeBtn.layer.borderWidth = 3
        closeBtn.isHidden = true
        closeBtn.addTarget(self, action: #selector(closeBtnAction(sender:)), for: .touchUpInside)
        view.addSubview(closeBtn)
        closeBtn.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-80)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(60)
        }
    }
    
    @objc func playBtnAction(sender: UIButton){
        if sender.isSelected{
            sender.isSelected = false
            sender.setBackgroundImage(UIImage(named: "play_icon"), for: .normal)
            triggerTimer.invalidate()
            circularProgressBarView.progressStop()
        }else{
            sender.isSelected = true
            sender.setBackgroundImage(UIImage(named: "pause_icon"), for: .normal)
            setClockTimer()
        }
    }
    
    @objc func cancelBtnAction(sender: UIButton){
        let ac = UIAlertController(title: nil, message: "Do You Want Cancel This Timer?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .default) { Action in
            UIView.animate(withDuration: 0.3, animations: {
                self.bgView.alpha = 0
            })
            self.triggerTimer.invalidate()
            self.dismiss(animated: true)
        }
        let no = UIAlertAction(title: "No", style: .default)
        ac.addAction(yes)
        ac.addAction(no)
        present(ac , animated: true)
    }
    
    @objc func nextBtnAction(sender: UIButton){
        triggerTimer.invalidate()
        
        if currentArrayIndex == TimerArray.count - 1{
            currentArrayIndex = 0
        }else{
            currentArrayIndex += 1
        }
        setClockTimer()
    }
    
    @objc func closeBtnAction(sender : UIButton){
        currentDate = Date()
        let currentTimeStr = formatter.string(from: currentDate)
        let currentTimeDate = formatter.date(from: currentTimeStr)
        
        let result = startTimeDate.timeIntervalSince(endTimeDate)
        
        if result < 0 {
            timeOffset = endTimeDate.timeIntervalSince(currentTimeDate!)
            if timeOffset > 0 {
                if currentArrayIndex == TimerArray.count - 1{
                    currentArrayIndex = 0
                }else{
                    currentArrayIndex += 1
                }
                setClockTimer()
            }else{
                setTriggerTimer()
            }
            
        }else if result > 0 {
            
            let add = 86400 - abs(result)
            let endDate = startTimeDate.addingTimeInterval(add)
            timeOffset = currentTimeDate!.timeIntervalSince(endDate)
            
            if timeOffset < 0{
                if currentArrayIndex == TimerArray.count - 1{
                    currentArrayIndex = 0
                }else{
                    currentArrayIndex += 1
                }
                setClockTimer()
            }else{
                setTriggerTimer()
            }
        }
        uiShowHide(countEnd: false)
    }
    
    func setTriggerTimer(){
        nextBtn.isEnabled = false
        nextBtn.alpha = 0.5
        
        playBtn.isEnabled = false
        playBtn.alpha = 0.5
        playBtn.isSelected = true
        playBtn.setBackgroundImage(UIImage(named: "pause_icon"), for: .normal)
        
        currentDate = Date()
        formatter.dateFormat = "HH : mm : ss"
        let currentTimeStr = formatter.string(from: currentDate)
        let currentTimeDate = formatter.date(from: currentTimeStr)
        
        timeOffset = startTimeDate.timeIntervalSince(currentTimeDate!)
        
        if timeOffset < 0 {
            timeOffset = 86400 - abs(timeOffset)
        }
        
        triggerTimeAction()
        circularProgressBarView.progressAnimation(duration: timeOffset)
        triggerTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(triggerTimeAction), userInfo: nil, repeats: true)
    }
    
    @objc func triggerTimeAction(){
        
        updateCountUI()
        
        if timeOffset <= 0 {
            triggerTimer.invalidate()
            playBtn.isEnabled = true
            playBtn.alpha = 1
            nextBtn.isEnabled = true
            nextBtn.alpha = 1
            
            setClockTimer()
        }
    }
    
    func setClockTimer(){
        let index = TimerArray[currentArrayIndex]
        timeOffset = 0.0
        timeOffset += Double(index.hour) * 60 * 60
        timeOffset += Double(index.min) * 60
        timeOffset += Double(index.sec)
        
        clockTimerAction()
        circularProgressBarView.progressAnimation(duration: timeOffset)
        triggerTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(clockTimerAction), userInfo: nil, repeats: true)
    }
    
    @objc func clockTimerAction(){
        updateCountUI()
        
        if timeOffset <= 0{
            triggerTimer.invalidate()
            uiShowHide(countEnd: true)
            clockAnime()
        }
    }
    
    func updateCountUI(){
        
        timeOffset -= 1
        
        countHourInt = Int(timeOffset) / 60 / 60
        countMinInt = Int(timeOffset) / 60 % 60
        countSecInt = Int(timeOffset) % 60
        
        if countHourInt < 10{
            countHourLabel.attributedText = NSAttributedString(string: "0\(String(countHourInt))" ,attributes: [NSAttributedString.Key.kern: 2 ])
        }else{
            countHourLabel.attributedText = NSAttributedString(string: String(countHourInt) ,attributes: [NSAttributedString.Key.kern: 2 ])
        }
        
        if countMinInt < 10{
            countMinLabel.attributedText = NSAttributedString(string: "0\(String(countMinInt))" ,attributes: [NSAttributedString.Key.kern: 2 ])
        }else{
            countMinLabel.attributedText = NSAttributedString(string: String(countMinInt) ,attributes: [NSAttributedString.Key.kern: 2 ])
        }
        
        if countSecInt < 10{
            countSecLabel.attributedText = NSAttributedString(string: "0\(String(countSecInt))" ,attributes: [NSAttributedString.Key.kern: 2 ])
        }else{
            countSecLabel.attributedText = NSAttributedString(string: String(countSecInt) ,attributes: [NSAttributedString.Key.kern: 2 ])
        }
    }
    
    func uiShowHide(countEnd : Bool){
        circleBgView.isHidden = countEnd
        circularProgressBarView.isHidden = countEnd
        countHourLabel.isHidden = countEnd
        countMinLabel.isHidden = countEnd
        countSecLabel.isHidden = countEnd
        countHMColonLabel.isHidden = countEnd
        countMSColonLabel.isHidden = countEnd
        countStateLabel.isHidden = countEnd
        cancelBtn.isHidden = countEnd
        playBtn.isHidden = countEnd
        nextBtn.isHidden = countEnd
        clockIV.isHidden = !countEnd
        clockEffectIV.isHidden = !countEnd
        closeBtn.isHidden = !countEnd
    }
    
    func clockAnime(){
        UIView.animate(withDuration: 0.05, animations: {
            self.clockIV.transform = CGAffineTransform(rotationAngle: (Double.pi * 2) / 360 * -3 )
        }) { done in
            if done{
                self.clockIV.transform = CGAffineTransform(rotationAngle: (Double.pi * 2) / 360 * 3)
                self.clockAnime()
            }
        }
    }
}
