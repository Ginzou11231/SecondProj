//
//  CustomCollectionCell.swift
//  SecondProject
//
//  Created by 邱裕芳 on 2023/6/14.
//

import UIKit
import SnapKit

class TimerCollectionCell: UICollectionViewCell {
    
    static var cellIdentifier : String = "TimerCell"
    
    var numLabel , unitLabel , customLabel : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        backgroundColor = UIColor(cgColor: CGColor(red: 79 / 255, green: 177 / 255, blue: 252 / 255, alpha: 1))
        layer.cornerRadius = 35
        layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        layer.borderWidth = 3
        
        numLabel = UILabel()
        numLabel.attributedText = NSAttributedString(string: "00" , attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
            NSAttributedString.Key.kern: 1 ,
            NSAttributedString.Key.foregroundColor: UIColor(cgColor: CGColor(red: 1, green: 1 , blue: 1, alpha: 1))])
        numLabel.textAlignment = .center
        addSubview(numLabel)
        numLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
        }
        
        unitLabel = UILabel()
        unitLabel.attributedText = NSAttributedString(string: "min" , attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.kern: 1 ,
            NSAttributedString.Key.foregroundColor: UIColor(cgColor: CGColor(red: 1, green: 1 , blue: 1, alpha: 1))])
        unitLabel.textAlignment = .center
        addSubview(unitLabel)
        unitLabel.snp.makeConstraints { make in
            make.top.equalTo(numLabel.snp.bottom).offset(-5)
            make.centerX.equalToSuperview()
        }
        
        customLabel = UILabel()
        customLabel.attributedText = NSAttributedString(string: "custom" , attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: UIColor(cgColor: CGColor(red: 1, green: 1 , blue: 1, alpha: 1))])
        customLabel.textAlignment = .center
        addSubview(customLabel)
        customLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
