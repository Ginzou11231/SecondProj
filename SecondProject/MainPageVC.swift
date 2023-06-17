//
//  MainPage.swift
//  SecondProject
//
//  Created by 邱裕芳 on 2023/6/12.
//

import UIKit
import SnapKit

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}

protocol CustomTimerArrayDelegate{
    func setTimers(array : [TimerModel])
    func getTimers() -> [TimerModel]
}

class MainPageVC: UIViewController, CustomTimerArrayDelegate {
    func setTimers(array: [TimerModel]) {
        customTimers = array
        saveArrayData()
    }
    
    func getTimers() -> [TimerModel] {
        return customTimers
    }
    
    func saveArrayData(){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(customTimers)
            UserDefaults.standard.set(data, forKey: "ArrayDatas")
        } catch {
            print("Unable to Encode Array of Notes (\(error))")
        }
    }
    
    func loadArrayData(){
        if let data = UserDefaults.standard.data(forKey: "ArrayDatas") {
            do {
                let decoder = JSONDecoder()
                customTimers = try decoder.decode([TimerModel].self, from: data)
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
    }
    
    var bgView : UIView!
    var hourLabel , minLabel , colonLabel , amLabel , pmLabel , seperateLabel: UILabel!
    var modeBtn , customBtn : UIButton!
    
    var customTimers :[TimerModel] = []
    
    var date = NSDate()
    var formatter = DateFormatter()
    var currentTimer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        uiInit()
        timerAction()
        loadArrayData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        colonLabel.alpha = 1
        currentTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        currentTimer.invalidate()
    }
    
    func uiInit(){
        
        navigationItem.title = "Stand Up+"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20) ,
            NSAttributedString.Key.foregroundColor : UIColor.yellow ,
            NSAttributedString.Key.kern: 3]
        
        view.backgroundColor = UIColor(cgColor: CGColor(red: 171 / 255, green: 225 / 255, blue: 254 / 255, alpha: 1))
        
        bgView = UIView()
        bgView.layer.shadowOffset = CGSize(width: 2, height: 2)
        bgView.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        bgView.layer.shadowOpacity = 0.5
        bgView.layer.cornerRadius = UIScreen.main.bounds.width
        bgView.backgroundColor = UIColor(cgColor: CGColor(red: 79 / 255, green: 177 / 255, blue: 252 / 255, alpha: 1))
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-UIScreen.main.bounds.height / 2)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width * 2)
            make.height.equalTo(UIScreen.main.bounds.height)
        }
        
        colonLabel = UILabel()
        colonLabel.text = ":"
        colonLabel.font = .boldSystemFont(ofSize: 100)
        colonLabel.textAlignment = .center
        colonLabel.textColor = .yellow
        
        view.addSubview(colonLabel)
        colonLabel.snp.makeConstraints { make in
            make.top.equalTo(UIScreen.main.bounds.height / 5)
            make.centerX.equalToSuperview()
            make.height.equalTo(80)
        }
        
        formatter.dateFormat = "HH"
        let hour = formatter.string(from: date as Date)
        
        hourLabel = UILabel()
        hourLabel.attributedText = NSAttributedString(string: hour , attributes: [
            NSAttributedString.Key.kern: 5])
        
        hourLabel.font = .boldSystemFont(ofSize: 100)
        hourLabel.textColor = .yellow
        hourLabel.textAlignment = .center
        view.addSubview(hourLabel)
        hourLabel.snp.makeConstraints { make in
            make.top.equalTo(colonLabel).offset(5)
            make.leading.equalToSuperview()
            make.trailing.equalTo(colonLabel.snp.leading)
            make.height.equalTo(colonLabel)
        }
        
        formatter.dateFormat = "mm"
        let min = formatter.string(from: date as Date)
        
        minLabel = UILabel()
        minLabel.attributedText = NSAttributedString(string: min , attributes: [
            NSAttributedString.Key.kern: 5])

        minLabel.font = .boldSystemFont(ofSize: 100)
        minLabel.textColor = .yellow
        minLabel.textAlignment = .center
        view.addSubview(minLabel)
        minLabel.snp.makeConstraints { make in
            make.top.equalTo(colonLabel).offset(5)
            make.leading.equalTo(colonLabel.snp.trailing)
            make.trailing.equalToSuperview()
            make.height.equalTo(colonLabel)
        }
        
        seperateLabel = UILabel()
        seperateLabel.text = "|"
        seperateLabel.font = .boldSystemFont(ofSize: 30)
        seperateLabel.textAlignment = .center
        seperateLabel.textColor = .white
        view.addSubview(seperateLabel)
        seperateLabel.snp.makeConstraints { make in
            make.top.equalTo(colonLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        amLabel = UILabel()
        amLabel.text = "am"
        amLabel.font = .boldSystemFont(ofSize: 24)
        amLabel.textAlignment = .center
        amLabel.textColor = .white
        amLabel.backgroundColor = .clear
        amLabel.layer.cornerRadius = 15
        amLabel.clipsToBounds = true
        view.addSubview(amLabel)
        amLabel.snp.makeConstraints { make in
            make.top.equalTo(seperateLabel)
            make.leading.equalToSuperview().offset(70)
            make.trailing.equalTo(seperateLabel.snp.leading).offset(-30)
            make.height.equalTo(seperateLabel)
        }
        
        
        pmLabel = UILabel()
        pmLabel.text = "pm"
        pmLabel.font = .boldSystemFont(ofSize: 24)
        pmLabel.textAlignment = .center
        pmLabel.textColor = .white
        pmLabel.backgroundColor = .clear
        pmLabel.layer.cornerRadius = 15
        pmLabel.clipsToBounds = true
        view.addSubview(pmLabel)
        pmLabel.snp.makeConstraints { make in
            make.top.equalTo(seperateLabel)
            make.leading.equalTo(seperateLabel.snp.trailing).offset(30)
            make.trailing.equalToSuperview().offset(-70)
            make.height.equalTo(seperateLabel)
        }
    
        modeBtn = UIButton()
        modeBtn.setAttributedTitle(NSAttributedString(string: "Timer Mode" , attributes: [
            NSAttributedString.Key.kern: 3 ,
            NSAttributedString.Key.foregroundColor: UIColor.white ,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]), for: .normal)
        
        modeBtn.setAttributedTitle(NSAttributedString(string: "Timer Mode" , attributes: [
            NSAttributedString.Key.kern: 3 ,
            NSAttributedString.Key.foregroundColor: UIColor.lightGray ,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)]), for: .highlighted)
        
        modeBtn.setBackgroundColor(color: UIColor(cgColor: CGColor(red: 79 / 255, green: 177 / 255, blue: 252 / 255, alpha: 1)), forState: .normal)
        modeBtn.setBackgroundColor(color: UIColor(cgColor: CGColor(red: 39.5 / 255, green: 88.5 / 255, blue: 126 / 255, alpha: 1)), forState: .highlighted)
        
        modeBtn.layer.cornerRadius = 25
        modeBtn.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        modeBtn.layer.borderWidth = 3
        modeBtn.addTarget(self, action: #selector(modeBtnAction(sender:)), for: .touchUpInside)
        view.addSubview(modeBtn)
        modeBtn.snp.makeConstraints { make in
            make.top.equalTo(UIScreen.main.bounds.height / 1.7)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }
        
        customBtn = UIButton()
        customBtn.setAttributedTitle(NSAttributedString(string: "Customize Mode" , attributes: [
            NSAttributedString.Key.kern: 3 ,
            NSAttributedString.Key.foregroundColor: UIColor.white ,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]), for: .normal)
        
        customBtn.setAttributedTitle(NSAttributedString(string: "Customize Mode" , attributes: [
            NSAttributedString.Key.kern: 3 ,
            NSAttributedString.Key.foregroundColor: UIColor.lightGray ,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)]), for: .highlighted)
        
        customBtn.setBackgroundColor(color: UIColor(cgColor: CGColor(red: 79 / 255, green: 177 / 255, blue: 252 / 255, alpha: 1)), forState: .normal)
        customBtn.setBackgroundColor(color: UIColor(cgColor: CGColor(red: 39.5 / 255, green: 88.5 / 255, blue: 126 / 255, alpha: 1)), forState: .highlighted)
        
        customBtn.layer.cornerRadius = 25
        customBtn.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        customBtn.layer.borderWidth = 3
        customBtn.addTarget(self, action: #selector(customBtnAction(sender:)), for: .touchUpInside)
        view.addSubview(customBtn)
        customBtn.snp.makeConstraints { make in
            make.top.equalTo(modeBtn.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }
    }
    
    @objc func modeBtnAction(sender : UIButton){
        let vc = TimeModePageVC()
        vc.modalPresentationStyle = .fullScreen
        vc.customTimerDelegate = self
        present(vc , animated: true)
    }
    
    @objc func customBtnAction(sender : UIButton){
        let vc = CustomizeModePageVC()
        vc.modalPresentationStyle = .fullScreen
        vc.customTimerArray = self
        present(vc , animated: true)
    }
    
    @objc func timerAction(){
        if colonLabel.alpha == 1{
            colonLabel.alpha = 0
        }else{
            colonLabel.alpha = 1
        }

        date = NSDate()
        
        formatter.dateFormat = "HH"
        let hour = formatter.string(from: date as Date)
        
        let int = Int(hour)!
        
        if int / 12 == 0 {
            amLabel.backgroundColor = .systemBlue
            pmLabel.backgroundColor = .clear
            bgView.backgroundColor = UIColor(cgColor: CGColor(red: 79 / 255, green: 177 / 255, blue: 252 / 255, alpha: 1))
        }else{
            amLabel.backgroundColor = .clear
            pmLabel.backgroundColor = .orange
            bgView.backgroundColor = UIColor(cgColor: CGColor(red: 2 / 255, green: 69 / 255, blue: 113 / 255, alpha: 1))
        }
        
        if hourLabel.text != hour{
            hourLabel.attributedText = NSAttributedString(string: hour , attributes: [
                NSAttributedString.Key.kern: 5])
        }
        
        formatter.dateFormat = "mm"
        let min = formatter.string(from: date as Date)
        if minLabel.text != min{
            minLabel.attributedText = NSAttributedString(string: min , attributes: [
                NSAttributedString.Key.kern: 5])
        }
    }
    

}
