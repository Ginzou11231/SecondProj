//
//  AboutTableCell.swift
//  SecondProject
//
//  Created by 邱裕芳 on 2023/6/21.
//

import UIKit
import SnapKit

class AboutTableCell: UITableViewCell {
    
    static var cellIdentifier = "AboutCell"
    
    var bgView : UIView!
    var titleLabel , versionLabel : UILabel!
    var titleImage : UIImageView!
    var indexTextView : UITextView!

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 10
        
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel = UILabel()
        titleLabel.attributedText = NSAttributedString(string: "aa" , attributes: [
            NSAttributedString.Key.kern:2 ,
            NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20) ,
            NSAttributedString.Key.foregroundColor:UIColor(cgColor: CGColor(red: 2 / 255, green: 69 / 255, blue: 113 / 255, alpha: 1))])
        titleLabel.textAlignment = .left
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        
        indexTextView = UITextView()
        indexTextView.text = "aasasddoijsdoifjsodiidisodjfsoijfoijdfosijffjsdoifjsdofijzoijpsdjapj\nasd\n\nokofk"
        indexTextView.isEditable = false
        indexTextView.textAlignment = .left
        indexTextView.textColor = .black
        indexTextView.font = .boldSystemFont(ofSize: 16)
        indexTextView.isHidden = true
        
        addSubview(indexTextView)
        indexTextView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
        
        titleImage = UIImageView()
        titleImage.image = UIImage(systemName: "chevron.down")
        titleImage.contentMode = .scaleAspectFit
        titleImage.isHidden = true
        addSubview(titleImage)
        titleImage.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        versionLabel = UILabel()
        versionLabel.attributedText = NSAttributedString(string: "1.0.0" , attributes: [
            NSAttributedString.Key.kern:2 ,
            NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20) ,
            NSAttributedString.Key.foregroundColor:UIColor(cgColor: CGColor(red: 2 / 255, green: 69 / 255, blue: 113 / 255, alpha: 1))])
        versionLabel.textAlignment = .right
        versionLabel.isHidden = true
        addSubview(versionLabel)
        versionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
