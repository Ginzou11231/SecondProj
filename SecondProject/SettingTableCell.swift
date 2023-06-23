//
//  SettingTableCell.swift
//  SecondProject
//
//  Created by 邱裕芳 on 2023/6/19.
//

import UIKit
import SnapKit

class UnitSwitch : UISwitch{
    override func draw(_ rect: CGRect) {
        self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
    }
}

class SettingTableCell: UITableViewCell {
    
    static var cellIdentifier = "SettingCell"
    var titleLabel : UILabel!
    var titleswitch : UnitSwitch!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        titleswitch = UnitSwitch()
        titleswitch.isOn = true
        titleswitch.onTintColor = .yellow
        addSubview(titleswitch)
        titleswitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-30)
        }
        
        titleLabel = UILabel()
        titleLabel.attributedText = NSAttributedString(string: "aa" , attributes: [
            NSAttributedString.Key.kern:2 ,
            NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20) ,
            NSAttributedString.Key.foregroundColor:UIColor(cgColor: CGColor(red: 2 / 255, green: 69 / 255, blue: 113 / 255, alpha: 1)) ])
        titleLabel.textAlignment = .left
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(titleswitch.snp.leading)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
