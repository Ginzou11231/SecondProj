//
//  RootTBC.swift
//  SecondProject
//
//  Created by 邱裕芳 on 2023/6/12.
//

import UIKit
import SnapKit

class RootTBC: UITabBarController {
    
    var mainBtn , settingBtn , aboutBtn : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        createViewControllers()
        uiInit()
        mainBtn.layer.borderColor = CGColor(red: 0, green: 0, blue:0, alpha: 0.7)
    }

    func createViewControllers(){
        let firstVC = UINavigationController(rootViewController: MainPageVC())
        let secondVC = UINavigationController(rootViewController: SettingPageVC())
        let thirdVC = UINavigationController(rootViewController:AboutPageVC())
        
        setViewControllers([firstVC , secondVC , thirdVC], animated: true)
        
        for i in 0..<tabBar.items!.count{
            tabBar.items![i].isEnabled = false
        }
        selectedIndex = 0
    }

    func uiInit(){
        
        let tabBar = { () -> CustomTabbar in
            let tabBar = CustomTabbar()
            tabBar.delegate = self
            return tabBar
        }()
        self.setValue(tabBar, forKey: "tabBar")
        
        mainBtn = UIButton()
        setUIButton(button: mainBtn, image: UIImage(named: "main_icon"))
        mainBtn.backgroundColor = .white
        mainBtn.addTarget(self, action: #selector(mainBtnAction(sender:)), for: .touchUpInside)
        
        tabBar.addSubview(mainBtn)
        mainBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-30)
            make.leading.equalToSuperview().offset(40)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        settingBtn = UIButton()
        setUIButton(button: settingBtn, image: UIImage(named: "unsetting_icon"))
        settingBtn.addTarget(self, action: #selector(settingBtnAction(sender:)), for: .touchUpInside)
        
        tabBar.addSubview(settingBtn)
        settingBtn.snp.makeConstraints { make in
            make.top.equalTo(mainBtn)
            make.centerX.equalToSuperview()
            make.width.equalTo(mainBtn)
            make.height.equalTo(mainBtn)
        }
        
        aboutBtn = UIButton()
        setUIButton(button: aboutBtn, image: UIImage(named: "unabout_icon"))
        aboutBtn.addTarget(self, action: #selector(aboutBtnAction(sender:)), for: .touchUpInside)
        
        tabBar.addSubview(aboutBtn)
        aboutBtn.snp.makeConstraints { make in
            make.top.equalTo(mainBtn)
            make.trailing.equalToSuperview().offset(-40)
            make.width.equalTo(mainBtn)
            make.height.equalTo(mainBtn)
        }
    }
    
    func setUIButton(button : UIButton , image : UIImage?){
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.layer.borderColor = CGColor(red: 0, green: 0, blue:0, alpha: 0)
        button.layer.borderWidth = 2
        button.clipsToBounds = false
        button.adjustsImageWhenHighlighted = false
    }
    
    @objc func mainBtnAction(sender : UIButton){
        selectedIndex = 0
        mainBtn.backgroundColor = .white
        mainBtn.layer.borderColor = CGColor(red: 0, green: 0, blue:0, alpha: 1)
        mainBtn.setImage(UIImage(named: "main_icon"), for: .normal)
        settingBtn.backgroundColor = .clear
        settingBtn.layer.borderColor = CGColor(red: 0, green: 0, blue:0, alpha: 0)
        settingBtn.setImage(UIImage(named: "unsetting_icon"), for: .normal)
        aboutBtn.backgroundColor = .clear
        aboutBtn.layer.borderColor = CGColor(red: 0, green: 0, blue:0, alpha: 0)
        aboutBtn.setImage(UIImage(named: "unabout_icon"), for: .normal)
    }
    
    @objc func settingBtnAction(sender : UIButton){
        selectedIndex = 1
        mainBtn.backgroundColor = .clear
        mainBtn.layer.borderColor = CGColor(red: 0, green: 0, blue:0, alpha: 0)
        mainBtn.setImage(UIImage(named: "unmain_icon"), for: .normal)
        settingBtn.backgroundColor = .white
        settingBtn.layer.borderColor = CGColor(red: 0, green: 0, blue:0, alpha: 1)
        settingBtn.setImage(UIImage(named: "setting_icon"), for: .normal)
        aboutBtn.backgroundColor = .clear
        aboutBtn.layer.borderColor = CGColor(red: 0, green: 0, blue:0, alpha: 0)
        aboutBtn.setImage(UIImage(named: "unabout_icon"), for: .normal)
    }
    
    @objc func aboutBtnAction(sender : UIButton){
        selectedIndex = 2
        mainBtn.backgroundColor = .clear
        mainBtn.layer.borderColor = CGColor(red: 0, green: 0, blue:0, alpha: 0)
        mainBtn.setImage(UIImage(named: "unmain_icon"), for: .normal)
        settingBtn.backgroundColor = .clear
        settingBtn.layer.borderColor = CGColor(red: 0, green: 0, blue:0, alpha: 0)
        settingBtn.setImage(UIImage(named: "unsetting_icon"), for: .normal)
        aboutBtn.backgroundColor = .white
        aboutBtn.layer.borderColor = CGColor(red: 0, green: 0, blue:0, alpha: 1)
        aboutBtn.setImage(UIImage(named: "about_icon"), for: .normal)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let position = touch.location(in: tabBar)
            if position.x >= mainBtn.frame.minX && position.x <= mainBtn.frame.maxX{
                if position.y >= mainBtn.frame.minY && position.y <= mainBtn.frame.maxY{
                    mainBtnAction(sender: mainBtn)
                }
            }
            
            if position.x >= settingBtn.frame.minX && position.x <= settingBtn.frame.maxX{
                if position.y >= settingBtn.frame.minY && position.y <= settingBtn.frame.maxY{
                    settingBtnAction(sender: settingBtn)
                }
            }
            
            if position.x >= aboutBtn.frame.minX && position.x <= aboutBtn.frame.maxX{
                if position.y >= aboutBtn.frame.minY && position.y <= aboutBtn.frame.maxY{
                    aboutBtnAction(sender: aboutBtn)
                }
            }
        }
    }
}
