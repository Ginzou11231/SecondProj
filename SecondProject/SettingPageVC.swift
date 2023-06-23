//
//  SettingPageVC.swift
//  SecondProject
//
//  Created by 邱裕芳 on 2023/6/12.
//

import UIKit
import SnapKit

class SettingPageVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    var titleBGView : UIView!
    var settingTableView : UITableView!
    var reminderBool , soundBool : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = UserDefaults.standard.object(forKey: "ReminderBool") {
            reminderBool = (data as! Bool)
        }else{
            reminderBool = true
        }
        if let data = UserDefaults.standard.object(forKey: "SoundBool") {
            soundBool = (data as! Bool)
        }else{
            soundBool = true
        }
        
        uiInit()
    }
    
    func uiInit(){
        navigationItem.title = "SETTING"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24) ,
            NSAttributedString.Key.kern: 2 ,
            NSAttributedString.Key.foregroundColor : UIColor(cgColor: CGColor(red: 2 / 255, green: 69 / 255, blue: 113 / 255, alpha: 1))]
        
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
        
        settingTableView = UITableView()
        settingTableView.dataSource = self
        settingTableView.delegate = self
        settingTableView.bounces = false
        settingTableView.backgroundColor = .clear
        settingTableView.register(SettingTableCell.self, forCellReuseIdentifier: SettingTableCell.cellIdentifier)
        settingTableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        view.addSubview(settingTableView)
        settingTableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-30)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableCell.cellIdentifier) as! SettingTableCell
        
        if indexPath.row == 0 {
            cell.titleLabel.attributedText = NSAttributedString(string: "Reminder Notification" , attributes: [
                NSAttributedString.Key.kern:1 ,
                NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20) ,
                NSAttributedString.Key.foregroundColor:UIColor(cgColor: CGColor(red: 2 / 255, green: 69 / 255, blue: 113 / 255, alpha: 1)) ])
            
            cell.titleswitch.isOn = reminderBool
        }else{
            cell.titleLabel.attributedText = NSAttributedString(string: "Timer Sound" , attributes: [
                NSAttributedString.Key.kern:1 ,
                NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20) ,
                NSAttributedString.Key.foregroundColor:UIColor(cgColor: CGColor(red: 2 / 255, green: 69 / 255, blue: 113 / 255, alpha: 1)) ])
            
            cell.titleswitch.isOn = soundBool
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            reminderBool = !reminderBool
            UserDefaults.standard.set(soundBool, forKey: "ReminderBool")
        }else{
            soundBool = !soundBool
            UserDefaults.standard.set(soundBool, forKey: "SoundBool")
        }
        tableView.reloadData()
    }
}
