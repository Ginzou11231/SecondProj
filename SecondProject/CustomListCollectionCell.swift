//
//  CustomPageCollectionCell.swift
//  SecondProject
//
//  Created by 邱裕芳 on 2023/6/15.
//

import UIKit
import SnapKit

class CustomListCollectionCell: UICollectionViewCell {
    
    static var cellIdentifier = "CustomizeCell"
    
    var numLabel , titleLabel : UILabel!
    var optionBtn : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 15
        layer.borderColor = CGColor(red: 127 / 255, green: 127 / 255, blue: 127 / 255, alpha: 0.5)
        layer.borderWidth = 2
        layer.shadowOffset = CGSize(width: 0 , height: 3)
        layer.shadowColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowOpacity = 0.5
        
        numLabel = UILabel()
        numLabel.text = "00"
        numLabel.font = .boldSystemFont(ofSize: 20)
        numLabel.textColor = UIColor(cgColor: CGColor(red: 79 / 255, green: 177 / 255, blue: 252 / 255, alpha: 1))
        numLabel.textAlignment = .left
        addSubview(numLabel)
        numLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(40)
        }
        
        optionBtn = UIButton()
        optionBtn.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        optionBtn.tintColor = .lightGray
        addSubview(optionBtn)
        optionBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(40)
        }
        
        titleLabel = UILabel()
        titleLabel.attributedText = NSAttributedString(string: "" , attributes: [
            NSAttributedString.Key.kern: 2 ,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20) ,
            NSAttributedString.Key.foregroundColor: UIColor(cgColor: CGColor(red: 2 / 255, green: 69 / 255, blue: 113 / 255, alpha: 1))
        ])

        titleLabel.textAlignment = .left
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(numLabel.snp.trailing)
            make.trailing.equalTo(optionBtn.snp.leading)
            make.bottom.equalToSuperview().offset(-10)
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
